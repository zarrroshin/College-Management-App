package Cli;
import Model.*;
import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class RemoveAssignmentFrame extends JFrame {

    private JTextField courseIdField;
    private JTextField assignmentNameField;

    public RemoveAssignmentFrame() {
        setTitle("حذف تمرین");
        setSize(400, 300);
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

        // Create submit button
        JButton submitButton = new JButton("حذف");
        submitButton.setBounds(150, 150, 100, 30);
        add(submitButton);

        // Add action listener to submit button
        submitButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String courseId = courseIdField.getText();
                String assignmentName = assignmentNameField.getText();
                teacherModel.DeleteAssignment(courseId, assignmentName);
            }
        });
    }

}