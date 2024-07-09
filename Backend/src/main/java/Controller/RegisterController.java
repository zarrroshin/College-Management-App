package Controller;

import Model.StudentModel;
import View.RegisterView;
import com.google.gson.JsonObject;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegisterController {
    RegisterView view;
    StudentModel model;

    public RegisterController(StudentModel model, RegisterView view) {
        this.view = view;
        this.model = model;
    }

    public JsonObject handleRegistration(String username, String student_id, String password, String password2) {
        JsonObject response = new JsonObject();
        // Passwords Verifications
        if (!password.equals(password2)) {
            System.out.println("Your Password aren't same !!!,Please try Again");
            response.addProperty("status", "error");
            response.addProperty("message", "Your Password aren't same !!!,Please try Again");
            return response;
        } else if (password.length() < 8) {
            System.out.println("Your Password too short !!!,Please Enter a Strong Password!");
            response.addProperty("status", "error");
            response.addProperty("message", "Your Password too short !!!,Please Enter a Strong Password!");
            return response;
        }

        // Check codeID should be just numbers and have a length between 4 and 8
        Pattern pattern = Pattern.compile("^[0-9]{4,8}$");
        Matcher matcher = pattern.matcher(student_id);
        if (!matcher.find()) {
            System.out.println("Your codeID should be an integer only and 4-8 digits long");
            response.addProperty("status", "error");
            response.addProperty("message", "Your codeID should be an integer only and 4-8 digits long");
            return response;
        }

        // Check Unique CodeID and Username
        if (model.CheckUnique(username, student_id)) {
            if (model.AddStudentToDataBase(username, student_id, password)) {
                System.out.println("Welcome " + username);
                response.addProperty("status", "success");
                response.addProperty("message", "register account was successfully");
            } else {
                response.addProperty("status", "error");
                response.addProperty("message", "An error occurred during registration, please try again ");
            }
        } else {
            System.out.println("This Username or CodeID Already exist! , Please Try Again");
            response.addProperty("status", "error");
            response.addProperty("message", "This username or student number already exists");
        }
        return response;

    }

    public boolean handleLoginControl(String username, String password) {

        if (model.Login(username, password)) {
            System.out.println("Successful login Welcome <3 :)");
            return true;
        }

        return false;
    }

    public String handleProfile(String username) {
        return model.getDetailStudent(username);
    }
}