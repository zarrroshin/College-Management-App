package Cli;
import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class AdminFrame extends JFrame {

    public AdminFrame() {
        setTitle("Admin Dashboard");
        setSize(400, 500);
        setLayout(null);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // Define admin actions
        JButton addCourse = new JButton("اضافه کردن درس جدید");
        JButton addTeacher = new JButton("اضافه کردن استاد جدید");
        JButton deleteTeacher = new JButton("حذف استاد");
        JButton defineExercise = new JButton("تعریف تمرین");
        JButton deleteExercise = new JButton("حذف تمرین");
        JButton registerGrade = new JButton("ثبت نمره");
        JButton addStudent = new JButton("اضافه کردن دانشجو");
        JButton deleteStudent = new JButton("حذف دانشجو");

        // Set bounds for buttons
        addCourse.setBounds(100, 20, 200, 30);
        addTeacher.setBounds(100, 70, 200, 30);
        deleteTeacher.setBounds(100, 120, 200, 30);
        defineExercise.setBounds(100, 170, 200, 30);
        deleteExercise.setBounds(100, 220, 200, 30);
        registerGrade.setBounds(100, 270, 200, 30);
        addStudent.setBounds(100, 320, 200, 30);
        deleteStudent.setBounds(100, 370, 200, 30);

        // Add buttons to the frame
        add(addCourse);
        add(addTeacher);
        add(deleteTeacher);
        add(defineExercise);
        add(deleteExercise);
        add(registerGrade);
        add(addStudent);
        add(deleteStudent);

        // Add action listeners for the buttons
        // You can implement the action logic here
        addCourse.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // Add course action
            }
        });

        addTeacher.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // Add teacher action
            }
        });

        deleteTeacher.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // Delete teacher action
            }
        });

        defineExercise.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // Define exercise action
            }
        });

        deleteExercise.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // Delete exercise action
            }
        });

        registerGrade.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // Register grade action
            }
        });

        addStudent.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // Add student action
            }
        });

        deleteStudent.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // Delete student action
            }
        });
    }
}
