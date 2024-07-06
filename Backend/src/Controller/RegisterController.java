package Controller;

import Model.StudentModel;
import View.RegisterView;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegisterController {
    RegisterView view;
    StudentModel model;

    public RegisterController(StudentModel model, RegisterView view) {
        this.view = view;
        this.model = model;
    }

    public boolean handleRegistration() {
        List<String> register_detail = view.authenticate_view();
        // Passwords Verifications
        int list_size = register_detail.size();
        if (!register_detail.get(list_size - 1)
                .equals(register_detail.get(list_size - 2))) {
            System.out.println("Your Password aren't same !!!,Please try Again");
            return false;
        } else if (register_detail.get(list_size - 1).length() < 8) {
            System.out.println("Your Password too short !!!,Please Enter a Strong Password!");
            return false;
        }

        // Check codeID should be just numbers and have a length between 4 and 8
        Pattern pattern = Pattern.compile("^[0-9]{4,8}$");
        Matcher matcher = pattern.matcher(register_detail.get(1));
        if (!matcher.find()) {
            System.out.println("Your codeID should be an integer only and 4-8 digits long");
            return false;
        }

        // Check Unique CodeID and Username
        if (model.CheckUnique(register_detail) && model.AddStudentToDataBase(register_detail)) {
            System.out.println("Welcome " + register_detail.get(0));
            return true;

        } else {
            System.out.println("This Username or CodeID Already exist! , Please Try Again");
            return false;
        }

    }

    public boolean handleLogin() {
        List<String> login_detail = view.login_view();
        String password = login_detail.get(0);
        String username_or_codeID = login_detail.get(1);

        if (model.Login(username_or_codeID,password) == 2) {
            System.out.println("Successful login Welcome <3 :)");
            return true;
        }

        return false;
    }
}
