package Model;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class StudentModel {
    private static final String FILE_PATH = "data/student.txt";
    private List<String[]> students;


    public StudentModel() {
        students = new ArrayList<String[]>();
        loadStudents();
    }

    private void loadStudents() {
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().indexOf('*') == 0) continue;
                String[] student_detail = line.split(",");
                if (student_detail.length >= 3)
                    students.add(student_detail);
            }
        } catch (IOException e) {
            System.out.println("Error!!");
            e.printStackTrace();
        }
    }

    public Boolean CheckUnique(String username, String codeID) {
        for (String[] student : students) {
            if (student[0].equalsIgnoreCase(username) || student[1].equalsIgnoreCase(codeID)) {
                return false;
            }
        }
        return true;

    }

    public Boolean Login(String username_or_codeId, String password) {


        for (String[] student : students) {
            if ((student[0].equalsIgnoreCase(username_or_codeId)
                    || student[1].equalsIgnoreCase(username_or_codeId))
                    &&
                    student[2].equalsIgnoreCase(password)) {
                return true;
            }

        }
        return false;
    }

    public Boolean AddStudentToDataBase(String username, String code_id, String password) {
        String text = username + ","
                + code_id + ","
                + password;
        List<String> register_list = new ArrayList<>();
        register_list.add(username);
        register_list.add(code_id);
        register_list.add(password);

        try {
            BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true));
            writer.newLine();
            writer.write(text);
            writer.close();
            students.add(register_list.toArray(new String[0]));
            return true;
        } catch (IOException ioe) {
            System.out.println("Something Went Wrong Please try again!!!");
            ioe.printStackTrace();
            register_list.remove(username);
            register_list.remove(code_id);
            register_list.remove(password);
            return false;
        }
    }

    public String getDetailStudent(String username) {
        for (String[] student : students) {
            if (student[0].equalsIgnoreCase(username)) {
                return student[0] + "-" + student[1] + "-" + student[3] + "-" + student[4];
            }
        }

        return "error";
    }

}