package Controller;

import Model.*;
import View.*;

public class MainController {
    private StudentModel studentModel;
    private RegisterController registerController;

    public MainController() {
        StudentModel studentModel = new StudentModel();
        RegisterView registerView = new RegisterView();

        registerController = new RegisterController(studentModel, registerView);
    }

    public void start() {
        boolean exit = false;
        while (!exit) {
            int choice = displayMainMenu();
            switch (choice) {
                case 1:
                    boolean check_register = registerController.handleRegistration();
                    if (check_register) {
                        exit = true;
                    }
                    break;
                case 2:
                    boolean check_login = registerController.handleLogin();
                    if (check_login) {
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
        return new java.util.Scanner(System.in).nextInt();
    }


}
