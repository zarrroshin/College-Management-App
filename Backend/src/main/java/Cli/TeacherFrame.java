package Cli;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class TeacherFrame extends JFrame {

    public TeacherFrame(String username) {
        setTitle("Teacher Dashboard");
        setSize(400, 400);
        setLayout(null);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // Define teacher actions
        JButton defineExercise = new JButton("تعریف تمرین");
        JButton deleteExercise = new JButton("حذف تمرین");
        JButton registerGrade = new JButton("ثبت نمره");


        // Set bounds for buttons
        defineExercise.setBounds(100, 50, 200, 30);
        deleteExercise.setBounds(100, 100, 200, 30);
        registerGrade.setBounds(100, 150, 200, 30);


        // Add buttons to the frame
        add(defineExercise);
        add(deleteExercise);
        add(registerGrade);


        // Add action listeners for the buttons
        defineExercise.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                new AddAssignmentFrame().setVisible(true); // Open add assignment frame
            }
        });

        deleteExercise.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                new RemoveAssignmentFrame().setVisible(true); // Open remove assignment frame
            }
        });

        registerGrade.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                new SetGradeFrame(username).setVisible(true); // Open set grade frame
            }
        });




    }
}
