package Connection;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class Server {
    public static void main(String[] args) throws IOException {
        System.out.println("Welcome to the server!");
        ServerSocket serverSocket = new ServerSocket(8080);
        while (true) {
            System.out.println("Wating for client...");
            new ClientHandler(serverSocket.accept()).start();
        }
    }
}


class ClientHandler extends Thread {
    Socket socket;
    DataOutputStream dos;
    DataInputStream dis;

    public ClientHandler(Socket socket) throws IOException {
        this.socket = socket;
        dos = new DataOutputStream(socket.getOutputStream());
        dis = new DataInputStream(socket.getInputStream());
        System.out.println("Connected to server");
    }

    public String listener() throws IOException {
        System.out.println("listener is activated");
        StringBuilder sb = new StringBuilder();
        int index = dis.read();
        while (index != 0) {
            sb.append((char) index);
            index = dis.read();
        }
        System.out.println("listener2 --> read command successfully");
        return sb.toString();
    }


    // Send the response to server
    public void writer(String write) throws IOException {
        dos.writeBytes(write);
        dos.flush();
        dos.close();
        dis.close();
        socket.close();
        System.out.println(write);
        System.out.println("command finished and response send");
    }


    @Override
    public void run() {
        super.run();
        String command;

        try {
            command = listener();
            System.out.println("command received { " + command + "}");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        String[] command_split = command.split("-");
        for (String item : command_split) {
            System.out.println(item);
        }

        // Check command split
//        switch (command_split[0]) {
//            case "GET : login": {
//
//            }
    }
}
