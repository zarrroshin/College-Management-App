package Connection;

import Controller.CourseController;
import Controller.RegisterController;
import Model.CourseOfferModel;
import Model.CourseStdModel;
import Model.StudentModel;
import Model.TeacherModel;
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
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Server {
    private static final int PORT = 8080;
    private static final Gson gson = new Gson();
    static StudentModel model = new StudentModel();
    static RegisterView view = new RegisterView();
    static TeacherModel teacherModel = new TeacherModel();

    static CourseStdModel courseStdModel = new CourseStdModel();
    static StudentModel studentModel = new StudentModel();
    static CourseOfferModel courseOfferModel = new CourseOfferModel();
    static CourseController courseController = new CourseController(courseOfferModel, teacherModel, courseStdModel, studentModel);
    static RegisterController registerController = new RegisterController(model, view);

    public static void main(String[] args) {
        System.out.println("Welcome to the server!");

        try (ServerSocket serverSocket = new ServerSocket(PORT)) {
            while (true) {
                System.out.println("Waiting for client...");
                Socket clientSocket = serverSocket.accept();
                System.out.println("Client connected: " + clientSocket);

                // Create a new thread for each client connection
                new ClientHandler(clientSocket, registerController, courseController).start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

class ClientHandler extends Thread {
    private final Socket socket;
    private final RegisterController registerController;
    private final CourseController courseController;

    public ClientHandler(Socket socket, RegisterController registerController, CourseController courseController) {
        this.socket = socket;
        this.registerController = registerController;
        this.courseController = courseController;
        System.out.println("Connected to client: " + socket);
    }

    @Override
    public void run() {
        try (DataOutputStream dos = new DataOutputStream(socket.getOutputStream());
             BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream(), StandardCharsets.UTF_8))) {
            String request;
            while ((request = reader.readLine())!= null) {
                System.out.println("Received request: " + request);
                String command = "";
                JsonObject jsonObject;
                if (request.startsWith("GET /") || request.contains("Dart")) {
                    command = request.split("/")[1].split(" ")[0];
                    if (command.startsWith("profileData")) {
                        String username = command.substring(command.indexOf("=") + 1);
                        handleProfileRequest(username, dos);

                    } else if (command.startsWith("classesData")) {
                        handleClassesRequest(dos);

                    } else if (command.startsWith("stdClassData")) {
                        String username = command.substring(command.indexOf("=") + 1);
                        handleStdClassesRequest(username, dos);

                    } else if (command.startsWith("addClassData")) {
                        Pattern pattern = Pattern.compile("studentId=([^&]+)&courseid=([^&]+)");
                        Matcher matcher = pattern.matcher(command);
                        if (matcher.find()) {
                            handleStdSaveInDataBase(matcher.group(1), matcher.group(2), dos);
                        } else {
                            System.out.println("data dosnt work!!!");
                        }
                    }
                } else if (request.contains("POST")) {
                    jsonObject = JsonParser.parseString(request).getAsJsonObject();
                    command = jsonObject.get("command").getAsString();
                    switch (command) {
                        case "POST:login" -> handleLogin(jsonObject, dos);
                        case "POST:register" -> handleRegister(jsonObject, dos);
                        case "POST:addTask" -> handleAddTask(jsonObject, dos);
                        default -> sendResponse(dos, "Unsupported command");
                    }
                } else {
                    System.out.println("server running!!");
                }
            }
        } catch (IOException e) {
            System.out.println("socket closed!!!!!!");
        } finally {
            closeSocket();
        }
    }

    private void handleStdSaveInDataBase(String user, String cpr_id, DataOutputStream dos) throws IOException {
        JsonObject responseJson = courseController.AddToCourseStudent(user, cpr_id);
        System.out.println("data :" + responseJson);
        sendResponseFetch(dos, responseJson.toString());
    }

    private void handleStdClassesRequest(String user, DataOutputStream dos) throws IOException {
        JsonObject responseJson = courseController.getStdCourseList(user);
        System.out.println("STD ::: " + responseJson);
        sendResponseFetch(dos, responseJson.toString());
    }

    private void handleClassesRequest(DataOutputStream dos) throws IOException {
        JsonObject responseJson = courseController.getCourseList();
        responseJson.addProperty("command", "GET:profile");
        sendResponseFetch(dos, responseJson.toString());
    }

    private void handleProfileRequest(String user, DataOutputStream dos) throws IOException {
        JsonObject responseJson = new JsonObject();
        responseJson.addProperty("command", "GET:profile");

        if (user != null) {
            String[] detailStudent = registerController.handleProfile(user).split("-");

            if (!detailStudent[0].equals("error")) {
                responseJson.addProperty("username", user);
                responseJson.addProperty("studentId", detailStudent[1]);
                responseJson.addProperty("department", detailStudent[2]);
                responseJson.addProperty("phone", detailStudent[3]);
            } else {
                responseJson.addProperty("error", "Student details not found!");
            }
        } else {
            responseJson.addProperty("error", "User not logged in!");
        }

        sendResponseFetch(dos, responseJson.toString());
    }

    private void handleAddTask(JsonObject jsonObject, DataOutputStream dos) throws IOException {
        String title = jsonObject.get("title").getAsString();
        String dateTimeString = jsonObject.get("dateTime").getAsString();

        // Process the task addition request
        System.out.println("Adding task: " + title + " at " + dateTimeString);

        // Simulate a successful response
        JsonObject responseJson = new JsonObject();
        responseJson.addProperty("command", "POST:addTask");
        responseJson.addProperty("status", "success");
        responseJson.addProperty("message", "Task added successfully!");

        sendResponseFetch(dos, responseJson.toString());
    }
    private void handleRegister(JsonObject jsonObject, DataOutputStream dos) throws IOException {
        String username = jsonObject.get("username").getAsString();
        String password = jsonObject.get("password").getAsString();
        String password2 = jsonObject.get("password2").getAsString();
        String student_id = jsonObject.get("studentId").getAsString();

        JsonObject response = registerController.handleRegistration(username, student_id, password, password2);
        sendResponse(dos, response.toString());
    }

    private void handleLogin(JsonObject jsonObject, DataOutputStream dos) throws IOException {
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

        sendResponse(dos, responseJson.toString());
    }

    private void sendResponse(DataOutputStream dos, String response) throws IOException {
        dos.writeBytes(response + "\n");
        dos.flush();
        System.out.println("Sent response: " + response);
    }

    private void sendResponseFetch(DataOutputStream dos, String response) throws IOException {
        dos.writeBytes("HTTP/1.1 200 OK\n");
        dos.writeBytes("Content-Type: application/json\n");
        dos.writeBytes("Access-Control-Allow-Origin: *\n");
        dos.writeBytes("\n"); // Empty line to indicate the end of headers
        dos.writeBytes(response + "\n");
        dos.flush();
        dos.close();
        System.out.println("Sent response: " + response);
    }

    private void closeSocket() {
        try {
            if (socket != null && !socket.isClosed()) {
                socket.close();
                System.out.println("Socket closed");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
