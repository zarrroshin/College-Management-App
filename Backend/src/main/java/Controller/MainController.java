package Controller;

import Model.StudentModel;
import View.RegisterView;

import java.util.Scanner;

public class MainController {
    private StudentModel studentModel;
    private RegisterController registerController;

    public MainController() {
        studentModel = new StudentModel(); // Fixed: Initialize the instance variable instead of creating a new local variable
        RegisterView registerView = new RegisterView();

        registerController = new RegisterController(studentModel, registerView);
    }

    public void start() {
        boolean exit = false;
        while (!exit) {
            int choice = displayMainMenu();
            switch (choice) {
                case 1:
                    boolean checkRegister = registerController.handleRegistration();
                    if (checkRegister) {
                        exit = true;
                    }
                    break;
                case 2:
                    boolean checkLogin = registerController.handleLogin();
                    if (checkLogin) {
                        exit = true;
                    }
                    break;
                case 3:
                    // ToDo
                    break;
                case 4:
                    exit = true;
                    break;
                default:
                    System.out.println("Invalid choice! Please try again.");
            }
        }
    }

    private int displayMainMenu() {
        System.out.println("1. Register User");
        System.out.println("2. Login User");
        System.out.println("3. Manage Student");
        System.out.println("4. Exit");
        System.out.print("Enter your choice: ");
        return new Scanner(System.in).nextInt(); // Fixed: Create Scanner instance directly
    }
}
