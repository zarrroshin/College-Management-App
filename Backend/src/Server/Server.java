import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class Server {
    public static void main(String[] args) throws IOException {
        System.out.println("Welcome to the server!");
        ServerSocket serverSocket = new ServerSocket(8080); // Changed port number to 9090
        while (true) {
            System.out.println("Waiting for client");
            new ClientHandler(serverSocket.accept()).start();

        }

    }
}

class ClientHandler extends Thread {
    Socket socket;
    DataOutputStream dos;
    DataInputStream dis;
    StudentModel studentModel = new StudentModel();

    ClientHandler(Socket socket) throws IOException {
        this.socket = socket;
        dos = new DataOutputStream(socket.getOutputStream());
        dis = new DataInputStream(socket.getInputStream());
        System.out.println("connected to server");

    }

    public String listener() throws IOException {
        System.out.println("listener is activated");
        StringBuilder sb = new StringBuilder();
        int index = dis.read();
        while (index != 0) {
            sb.append((char) index);
            index = dis.read();
        }
        System.out.println("Listener2 -> read command successfully");
        return sb.toString();
    }

    public void writer(String write) throws IOException {
        dos.writeBytes(write);
        dos.flush();
        dos.close();
        dis.close();
        socket.close();
        System.out.println(write);
    }

    @Override
    public void run() {
        super.run();
        String command;
        try {
            command = listener();
            System.out.println("command recived {" + command + "}");

        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        String[] split = command.split("~");
        for (String s : split) {
            System.out.println(s);
        }
        switch (split[0]) {
            case "GET: loginChecker": {
                boolean signedIn = false;
                int responseofDatabase = 100;
                try {

                    responseofDatabase = studentModel.Login(split[1], split[2]);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                if (responseofDatabase == 2) {
                    signedIn = true;
                    System.out.println("status code is 200");
                    System.out.println("Successfuly logged in!");
                    try {
                        writer("200");
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                } else if (responseofDatabase == 1) {
                    signedIn = false;
                    System.out.println("status code is 401");
                    System.out.println("password is incorrect");
                    try {
                        writer("401");
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                } else if (responseofDatabase == 0) {
                    signedIn = false;
                    System.out.println("status code is 404");
                    System.out.println("User not found");
                    try {
                        writer("404");
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }

                break;

            default:
                break;
        }

    }
}
