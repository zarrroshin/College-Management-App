package Model;

import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class StudentModel {
    private static final String FILE_PATH = "data/student.txt";
    private static List<String[]> students;

    public StudentModel() {
        students = new ArrayList<String[]>();
        loadStudents();
    }

    private void loadStudents() {
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().indexOf('*') == 0)
                    continue;
                String[] student_detail = line.split(",");
                if (student_detail.length >= 3)
                    students.add(student_detail);
            }
        } catch (IOException e) {
            System.out.println("Error!!");
            e.printStackTrace();
        }
    }

    public Boolean CheckUnique(List<String> register_list) {
        // register list --- > username(0) codeID(1) ---> () means index length of list
        // is 2
        String username = register_list.get(0);
        String codeID = register_list.get(1);

        for (String[] student : students) {
            if (student[0].equalsIgnoreCase(username) || student[1].equalsIgnoreCase(codeID)) {
                return false;
            }
        }
        return true;

    }

    public static int Login(String username_or_codeID, String password) {
        int result = 0;
        for (String[] student : students) {
            if ((student[0].equalsIgnoreCase(username_or_codeID)
                    || student[1].equalsIgnoreCase(username_or_codeID))) {
                result = 1;
                if (student[2].equalsIgnoreCase(password)) {
                    result = 2;
                    return result;
                }

            }

        }
        return result;

    }

    public Boolean AddStudentToDataBase(List<String> register_list) {
        String text = register_list.get(0) + ","
                + register_list.get(1) + ","
                + register_list.get(2);
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
            return false;
        }
    }

}
