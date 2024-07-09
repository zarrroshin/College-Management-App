import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.*;
import javax.swing.*;
import Model.*;

public class Cli {

    public static void main(String[] args) {
        // Create a instance of super user model
        SuperuserModel superuserModel = new SuperuserModel();
        TeacherModel teacherModel = new TeacherModel();

        // Creating instance of JFrame
        JFrame frame = new JFrame();

        // Create text field for take input from user
        JTextField username_field = new JTextField();
        JPasswordField password_field = new JPasswordField();

        // Creating instance of JButton
        JButton button_login = new JButton("login");

        // Create label
        JLabel label_username = new JLabel("username : ");
        JLabel label_password = new JLabel("password : ");
        JLabel label_login_status = new JLabel("");


        // Create radio buttons for user role selection
        JRadioButton teacherButton = new JRadioButton("Teacher");
        JRadioButton adminButton = new JRadioButton("Admin");

        // Group the radio buttons
        ButtonGroup group = new ButtonGroup();
        group.add(teacherButton);
        group.add(adminButton);

        // Setting bounds for components
        label_username.setBounds(140, 140, 200, 20);
        username_field.setBounds(140, 160, 220, 20);
        label_password.setBounds(140, 200, 200, 20);
        password_field.setBounds(140, 220, 220, 20);
        teacherButton.setBounds(140, 260, 100, 20);
        adminButton.setBounds(260, 260, 100, 20);
        button_login.setBounds(140, 300, 220, 50);
        label_login_status.setBounds(140, 360, 220, 20);

        // Adding components to JFrame
        frame.add(button_login);
        frame.add(username_field);
        frame.add(password_field);
        frame.add(label_username);
        frame.add(label_password);
        frame.add(teacherButton);
        frame.add(adminButton);
        frame.add(label_login_status);

        // 400 width and 500 height
        frame.setSize(500, 600);
        frame.setResizable(false);

        // using no layout managers
        frame.setLayout(null);

        // making the frame visible
        frame.setVisible(true);


        // After Click On Buttons
        button_login.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String username = username_field.getText();
                String password = String.valueOf(password_field.getPassword());
                Boolean is_admin = adminButton.isSelected();
                boolean login_check;
                // Call the CheckLogin Function for enter user
                if(is_admin){
                   login_check = superuserModel.LoginSuperUser(username, password);

                }
                else{
                    login_check = teacherModel.LoginTeacher(username,password);
                }
                // Display login status message
                if (login_check) {
                    label_login_status.setText("Login successful. Welcome!");
                    // Open another frame or perform any other actions as needed
                    // For example, you can open another JFrame or change the content of this frame
                } else {
                    label_login_status.setText("Login failed. Please check your credentials.");
                }
            }
        });
    }
}
