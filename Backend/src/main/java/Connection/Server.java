package Connection;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class Server {
    private static final int PORT = 8080;
    private static final Gson gson = new Gson();

    public static void main(String[] args) {
        System.out.println("Welcome to the server!");

        try (ServerSocket serverSocket = new ServerSocket(PORT)) {
            while (true) {
                System.out.println("Waiting for client...");
                Socket clientSocket = serverSocket.accept();
                System.out.println("Client connected: " + clientSocket);

                // Create a new thread for each client connection
                new ClientHandler(clientSocket).start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

class ClientHandler extends Thread {
    private final Socket socket;
    private final DataOutputStream dos;
    private final DataInputStream dis;
    private final Gson gson = new Gson();
    private final JsonParser jsonParser = new JsonParser();

    public ClientHandler(Socket socket) throws IOException {
        this.socket = socket;
        this.dos = new DataOutputStream(socket.getOutputStream());
        this.dis = new DataInputStream(socket.getInputStream());
        System.out.println("Connected to client: " + socket);
    }

    @Override
    public void run() {
        try {
            String request = dis.readUTF();
            System.out.println("Received request: " + request);

            JsonObject jsonObject = jsonParser.parse(request).getAsJsonObject();
            String command = jsonObject.get("command").getAsString();

            switch (command) {
                case "POST:login": {
                    handleLogin(jsonObject);
                    break;
                }
                case "POST:profile": {
                    handleProfile(jsonObject);
                    break;
                }
                default:
                    sendResponse("Unsupported command");
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                dos.close();
                dis.close();
                socket.close();
                System.out.println("Connection closed");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private void handleLogin(JsonObject jsonObject) throws IOException {
        String username = jsonObject.get("username").getAsString();
        String password = jsonObject.get("password").getAsString();

        // Perform login logic, validate credentials, etc.
        // Simulate login success for demonstration
        boolean loginSuccessful = true;

        JsonObject responseJson = new JsonObject();
        responseJson.addProperty("command", "POST:login");
        if (loginSuccessful) {
            responseJson.addProperty("status", "success");
            responseJson.addProperty("message", "Login successful");
        } else {
            responseJson.addProperty("status", "error");
            responseJson.addProperty("message", "Invalid username or password");
        }

        sendResponse(responseJson.toString());
    }

    private void handleProfile(JsonObject jsonObject) throws IOException {
        // Handle profile related operations
        // This is just a placeholder, add your logic accordingly
        String userId = jsonObject.get("userId").getAsString();
        // Fetch profile data from database or other source
        // Construct response JSON
        JsonObject profileJson = new JsonObject();
        profileJson.addProperty("command", "POST:profile");
        profileJson.addProperty("userId", userId);
        profileJson.addProperty("name", "John Doe");
        profileJson.addProperty("email", "john.doe@example.com");
        // Add more profile details as needed

        sendResponse(profileJson.toString());
    }

    private void sendResponse(String response) throws IOException {
        dos.writeUTF(response);
        dos.flush();
        System.out.println("Sent response: " + response);
    }
}
