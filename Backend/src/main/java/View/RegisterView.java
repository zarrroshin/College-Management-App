package main.java.View;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class RegisterView {
    // for register we need (pk:username)(password)(again password)

    // Create a Private Scanner for user
    private Scanner input;

    public RegisterView() {
        input = new Scanner(System.in);
    }


    // Show to user for enter username detail
    public List<String> authenticate_view() {
        List<String> register_user_data = new ArrayList<String>();
        System.out.print("Enter your username : ");
        String username = input.nextLine();
        System.out.print("Enter your codeID : ");
        String codeID = input.nextLine();
        System.out.print("Enter your password : ");
        String password1 = input.nextLine();
        System.out.print("Enter again your password : ");
        String password2 = input.nextLine();

        // Now Add detail to a list for return it
        register_user_data.add(username);
        register_user_data.add(codeID);
        register_user_data.add(password1);
        register_user_data.add(password2);
        return register_user_data;
    }

    public List<String> login_view() {
        List<String> login_user_data = new ArrayList<String>();
        System.out.print("Enter your username Or codeID : ");
        String username_or_codeID = input.nextLine();
        System.out.print("Enter Your Password : ");
        String password = input.nextLine();

        // Add data to a list
        login_user_data.add(username_or_codeID);
        login_user_data.add(password);
        return login_user_data;
    }

}
