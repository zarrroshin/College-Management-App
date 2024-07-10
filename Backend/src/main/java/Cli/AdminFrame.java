package Cli;

import Controller.CourseController;
import Controller.TeacherController;
import Model.CourseOfferModel;
import Model.CourseStdModel;
import Model.StudentModel;
import Model.TeacherModel;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class AdminFrame extends JFrame {
    TeacherModel teacherModel = new TeacherModel();
    CourseOfferModel courseOfferModel = new CourseOfferModel();
    CourseStdModel courseStdModel =new CourseStdModel();
    StudentModel studentModel = new StudentModel();
    TeacherController teacherController = new TeacherController(teacherModel);
    CourseController courseController = new CourseController(courseOfferModel,teacherModel,courseStdModel,studentModel);

    public AdminFrame() {
        setTitle("Admin Dashboard");
        setSize(400, 500);
        setLayout(null);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // Define admin actions
        JButton addCourse = new JButton("اضافه کردن درس جدید");
        JButton addTeacher = new JButton("اضافه کردن استاد جدید");
        JButton deleteTeacher = new JButton("حذف استاد");

        // Set bounds for buttons
        addCourse.setBounds(100, 20, 200, 30);
        addTeacher.setBounds(100, 70, 200, 30);
        deleteTeacher.setBounds(100, 120, 200, 30);

        // Add buttons to the frame
        add(addCourse);
        add(addTeacher);
        add(deleteTeacher);

        // Add action listeners for the buttons
        addCourse.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JTextField courseNameField = new JTextField();
                JTextField teacherNameField = new JTextField();
                JTextField timeField = new JTextField();
                JTextField vahedField = new JTextField();
                JTextField numOfAssignField = new JTextField();

                Object[] message = {
                        "Course Name:", courseNameField,
                        "Teacher Name:", teacherNameField,
                        "Time:", timeField,
                        "Vahed:", vahedField,
                        "Number of Assignments:", numOfAssignField
                };

                int option = JOptionPane.showConfirmDialog(AdminFrame.this, message, "Add Course", JOptionPane.OK_CANCEL_OPTION);
                if (option == JOptionPane.OK_OPTION) {
                    String courseName = courseNameField.getText();
                    String teacherName = teacherNameField.getText();
                    String time = timeField.getText();
                    String vahed = vahedField.getText();
                    String numOfAssign = numOfAssignField.getText();

                    // Process the inputs (e.g., add the course to the database)
                    boolean check = courseController.AddNewCourse(courseName, teacherName, time, vahed, numOfAssign);
                    if (check) {
                        int response = JOptionPane.showConfirmDialog(AdminFrame.this, "Course added successfully. Do you want to add another?", "Success", JOptionPane.YES_NO_OPTION, JOptionPane.INFORMATION_MESSAGE);
                        if (response == JOptionPane.NO_OPTION) {
                            return;
                        } else {
                            actionPerformed(e); // Recursively call the action to add another course
                        }
                    } else {
                        JOptionPane.showMessageDialog(AdminFrame.this, "Failed to add course. Please check the inputs and try again.", "Error", JOptionPane.ERROR_MESSAGE);
                    }
                }
            }
        });


        addTeacher.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // Create a new dialog for adding a teacher
                JDialog dialog = new JDialog(AdminFrame.this, "Add Teacher", true);
                dialog.setSize(300, 300);
                dialog.setLayout(null);

                JLabel usernameLabel = new JLabel("Username:");
                usernameLabel.setBounds(10, 10, 100, 25);
                JTextField usernameField = new JTextField();
                usernameField.setBounds(120, 10, 150, 25);

                JLabel passwordLabel = new JLabel("Password:");
                passwordLabel.setBounds(10, 50, 100, 25);
                JPasswordField passwordField = new JPasswordField();
                passwordField.setBounds(120, 50, 150, 25);

                JLabel confirmPasswordLabel = new JLabel("Confirm Password:");
                confirmPasswordLabel.setBounds(10, 90, 150, 25);
                JPasswordField confirmPasswordField = new JPasswordField();
                confirmPasswordField.setBounds(120, 90, 150, 25);

                JButton submitButton = new JButton("Submit");
                submitButton.setBounds(90, 130, 100, 30);

                submitButton.addActionListener(new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        String username = usernameField.getText();
                        String password = new String(passwordField.getPassword());
                        String confirmPassword = new String(confirmPasswordField.getPassword());

                        if (!password.equals(confirmPassword)) {
                            JOptionPane.showMessageDialog(dialog, "Passwords do not match", "Error", JOptionPane.ERROR_MESSAGE);
                        } else {
                            // Process the inputs (e.g., add the teacher to the database)
                            Boolean check = teacherController.AddNewTeacher(username, password);
                            if (check) {
                                int response = JOptionPane.showConfirmDialog(dialog, "Teacher added successfully. Do you want to add another?", "Success", JOptionPane.YES_NO_OPTION, JOptionPane.INFORMATION_MESSAGE);
                                if (response == JOptionPane.NO_OPTION) {
                                    dialog.dispose();
                                } else {
                                    usernameField.setText("");
                                    passwordField.setText("");
                                    confirmPasswordField.setText("");
                                }
                            } else {
                                JOptionPane.showMessageDialog(dialog, "Failed to add teacher.", "Error", JOptionPane.ERROR_MESSAGE);
                            }
                        }
                    }
                });

                dialog.add(usernameLabel);
                dialog.add(usernameField);
                dialog.add(passwordLabel);
                dialog.add(passwordField);
                dialog.add(confirmPasswordLabel);
                dialog.add(confirmPasswordField);
                dialog.add(submitButton);

                dialog.setVisible(true);
            }
        });

        deleteTeacher.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String teacherId = JOptionPane.showInputDialog(AdminFrame.this, "Enter Teacher ID to delete:", "Delete Teacher", JOptionPane.PLAIN_MESSAGE);
                if (teacherId != null && !teacherId.trim().isEmpty()) {
                    boolean check = teacherController.DeleteTeacherById(teacherId.trim());
                    if (check) {
                        int response = JOptionPane.showConfirmDialog(AdminFrame.this, "Teacher deleted successfully. Do you want to delete another?", "Success", JOptionPane.YES_NO_OPTION, JOptionPane.INFORMATION_MESSAGE);
                        if (response == JOptionPane.NO_OPTION) {
                            return;
                        } else {
                            actionPerformed(e); // Recursively call the action to delete another teacher
                        }
                    } else {
                        JOptionPane.showMessageDialog(AdminFrame.this, "Failed to delete teacher. Please check the ID and try again.", "Error", JOptionPane.ERROR_MESSAGE);
                    }
                }
            }
        });


    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                new AdminFrame().setVisible(true);
            }
        });
    }
}
