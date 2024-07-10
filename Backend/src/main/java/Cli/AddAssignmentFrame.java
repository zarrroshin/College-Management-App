package Cli;

import Model.TeacherModel;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class AddAssignmentFrame extends JFrame {

    private JTextField courseIdField;
    private JTextField assignmentNameField;
    private JTextField deadlineField;
    private JCheckBox isActiveCheckBox;

    public AddAssignmentFrame() {
        setTitle("تعریف تمرین");
        setSize(400, 400);
        setLayout(null);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        TeacherModel teacherModel =new TeacherModel();
        // Create labels and text fields
        JLabel courseIdLabel = new JLabel("کد درس:");
        courseIdLabel.setBounds(50, 50, 100, 20);
        add(courseIdLabel);

        courseIdField = new JTextField();
        courseIdField.setBounds(150, 50, 200, 20);
        add(courseIdField);

        JLabel assignmentNameLabel = new JLabel("نام تمرین:");
        assignmentNameLabel.setBounds(50, 100, 100, 20);
        add(assignmentNameLabel);

        assignmentNameField = new JTextField();
        assignmentNameField.setBounds(150, 100, 200, 20);
        add(assignmentNameField);

        JLabel deadlineLabel = new JLabel("تاریخ ددلاین:");
        deadlineLabel.setBounds(50, 150, 100, 20);
        add(deadlineLabel);

        deadlineField = new JTextField();
        deadlineField.setBounds(150, 150, 200, 20);
        add(deadlineField);

        JLabel isActiveLabel = new JLabel("فعال:");
        isActiveLabel.setBounds(50, 200, 100, 20);
        add(isActiveLabel);

        isActiveCheckBox = new JCheckBox();
        isActiveCheckBox.setBounds(150, 200, 20, 20);
        add(isActiveCheckBox);

        // Create submit button
        JButton submitButton = new JButton("ثبت");
        submitButton.setBounds(150, 250, 100, 30);
        add(submitButton);

        // Add action listener to submit button
        submitButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String courseId = courseIdField.getText();
                String assignmentName = assignmentNameField.getText();
                String deadline = deadlineField.getText();
                boolean isActive = isActiveCheckBox.isSelected();
                String str;
                if(isActive){
                    str="true";
                }
                else{
                    str="false";
                }
                teacherModel.DefineAssignmentTeacher(courseId, assignmentName, str, deadline);
            }
        });
    }


}
