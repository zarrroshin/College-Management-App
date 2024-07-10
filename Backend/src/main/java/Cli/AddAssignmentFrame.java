package Cli;
import Controller.TeacherController;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import Model.*;
import Controller.TeacherController;
public class DefineExerciseFrame extends JFrame {

    private JTextField nameField;
    private JTextField courseIdField;
    private JTextField deadlineField;
    private JTextField isActiveField;
    private JTextField assignmentIdField;
    TeacherModel teacherModel = new TeacherModel();
    TeacherController teacherController = new TeacherController(teacherModel);

    public DefineExerciseFrame(String username) {
        setTitle("تعریف تمرین");
        setSize(300, 300);
        setLayout(null);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

        // Create labels and text fields
        JLabel studentIdLabel = new JLabel("شماره دانشجویی:");
        studentIdLabel.setBounds(50, 50, 100, 20);
        add(studentIdLabel);

        studentIdField = new JTextField();
        studentIdField.setBounds(150, 50, 100, 20);
        add(studentIdField);

        JLabel courseIdLabel = new JLabel("کد درس:");
        courseIdLabel.setBounds(50, 100, 100, 20);
        add(courseIdLabel);

        courseIdField = new JTextField();
        courseIdField.setBounds(150, 100, 100, 20);
        add(courseIdField);

        JLabel gradeLabel = new JLabel("نمره:");
        gradeLabel.setBounds(50, 150, 100, 20);
        add(gradeLabel);

        gradeField = new JTextField();
        gradeField.setBounds(150, 150, 100, 20);
        add(gradeField);

        // Create submit button
        JButton submitButton = new JButton("ثبت");
        submitButton.setBounds(100, 200, 100, 30);
        add(submitButton);

        // Add action listener to submit button
        submitButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String studentId = studentIdField.getText();
                String courseId = courseIdField.getText();
                String grade = gradeField.getText();
                teacherModel.SetGrade(username, studentId, courseId, grade);
            }
        });
    }


}
