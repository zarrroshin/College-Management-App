package Connection;

import Controller.RegisterController;
import Model.StudentModel;
import View.RegisterView;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.charset.StandardCharsets;

public class Server {
    private static final int PORT = 8080;
    private static final Gson gson = new Gson();
    static StudentModel model = new StudentModel();
    static RegisterView view = new RegisterView();
    static RegisterController registerController = new RegisterController(model, view);

    public static void main(String[] args) {
        System.out.println("Welcome to the server!");

        try (ServerSocket serverSocket = new ServerSocket(PORT)) {
            while (true) {
                System.out.println("Waiting for client...");
                Socket clientSocket = serverSocket.accept();
                System.out.println("Client connected: " + clientSocket);

                // Create a new thread for each client connection
                new ClientHandler(clientSocket, registerController).start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

class ClientHandler extends Thread {
    private final Socket socket;
    private final DataOutputStream dos;
    private final BufferedReader reader;
    private final RegisterController registerController;

    public ClientHandler(Socket socket, RegisterController registerController) throws IOException {
        this.socket = socket;
        this.dos = new DataOutputStream(socket.getOutputStream());
        this.reader = new BufferedReader(new InputStreamReader(socket.getInputStream(), StandardCharsets.UTF_8));
        this.registerController = registerController;
        System.out.println("Connected to client: " + socket);
    }

    @Override
    public void run() {
        try {
            String request;
            while ((request = reader.readLine()) != null) {
                System.out.println("Received request: " + request);

                JsonObject jsonObject = JsonParser.parseString(request).getAsJsonObject();
                String command = jsonObject.get("command").getAsString();
                switch (command) {
                    case "POST:login": {
                        handleLogin(jsonObject);
                        break;
                    }
                    case "POST:register": {
                        handleRegister(jsonObject);
                        break;
                    }
                    default:
                        sendResponse("Unsupported command");
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                dos.close();
                reader.close();
                socket.close();
                System.out.println("Connection closed");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private void handleRegister(JsonObject jsonObject) throws IOException {
        String username = jsonObject.get("username").getAsString();
        String password = jsonObject.get("password").getAsString();
        String password2 = jsonObject.get("password2").getAsString();
        String student_id = jsonObject.get("studentId").getAsString();


        JsonObject response = registerController.handleRegistration(username, student_id, password, password2);
        sendResponse(response.toString());

    }

    private void handleLogin(JsonObject jsonObject) throws IOException {
        String username = jsonObject.get("username").getAsString();
        String password = jsonObject.get("password").getAsString();

        boolean loginSuccessful = registerController.handleLoginControl(username, password);

        JsonObject responseJson = new JsonObject();
        responseJson.addProperty("command", "POST:login");
        if (loginSuccessful) {
            responseJson.addProperty("status", "success");
            responseJson.addProperty("message", "welcome!<3");
        } else {
            responseJson.addProperty("status", "error");
            responseJson.addProperty("message", "username or password incorrect");
        }

        sendResponse(responseJson.toString());
    }

    private void sendResponse(String response) throws IOException {
        dos.writeBytes(response + "\n");
        dos.flush();
        System.out.println("Sent response: " + response);
    }
}
