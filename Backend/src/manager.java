import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Scanner;

public class manager {
    private static List<String[]> super_user = new ArrayList<>(); // Initialize super_user list

    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        if (args.length == 1) {
            if (args[0].equalsIgnoreCase("createsuperuser")) {
                System.out.print("enter Your username : ");
                String username = input.nextLine();
                System.out.print("Enter Your password : ");
                String password1 = input.nextLine();
                System.out.print("again Enter Your password : ");
                String password2 = input.nextLine();
                if (register_super_user(username, password1, password2)) {
                    System.out.println("Superuser created successfully.");
                } else {
                    System.out.println("Failed to create superuser.");
                }
            }
        }
    }

    public static Boolean register_super_user(String username, String password1, String password2) {
        if (!Objects.equals(password1, password2)) {
            System.out.println("Your Passwords aren't the same!!"); // Grammar fix
            return false;
        }
        try (BufferedReader reader = new BufferedReader(new FileReader("data/super_user.txt"))) {
            String line;
            String[] super_user_detail = null; // Initialize to avoid potential null reference
            int last_super_user_id = 0;
            while ((line = reader.readLine()) != null) {
                if (line.trim().indexOf('*') == 0) continue;
                super_user_detail = line.split(",");
                if (Objects.equals(username, super_user_detail[0])) {
                    System.out.println("Username already exists!");
                    return false;
                }
                int current_super_user_id = Integer.parseInt(super_user_detail[2].trim()); // Get the actual super_user_id
                if (current_super_user_id > last_super_user_id) {
                    last_super_user_id = current_super_user_id;
                }
            }
            last_super_user_id++;
            String superuser_id = Integer.toString(last_super_user_id);
            String text = username + "," + password1 + "," + superuser_id; // Fix order to match original format
            BufferedWriter writer = new BufferedWriter(new FileWriter("data/super_user.txt", true));
            writer.newLine();
            writer.write(text);
            writer.close();
            return true;
        } catch (IOException e) {
            System.out.println("Error!!");
            e.printStackTrace();
            return false;
        }
    }

    public static void setSuper_user(List<String[]> super_user) {
        manager.super_user = super_user;
    }
}
