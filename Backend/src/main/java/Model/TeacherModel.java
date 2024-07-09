package Model;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class TeacherModel {
    List<String[]> teachers;
    private static final String FILE_PATH = "data/teacher.txt";

    public TeacherModel() {
        teachers = new ArrayList<String[]>();
        loadTeacher();
    }

    private void loadTeacher() {
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().indexOf('*') == 0) continue;
                String[] teacher_detail = line.split(",");
                if (teacher_detail.length >= 3)
                    teachers.add(teacher_detail);
            }
        } catch (IOException e) {
            System.out.println("Error!!");
            e.printStackTrace();
        }
    }

    public boolean LoginTeacher(String username, String password) {
        for (String[] item : teachers) {
            if (item[0].equalsIgnoreCase(username) && item[1].equalsIgnoreCase(password)) {
                return true;
            }
        }
        return false;
    }

    public String getNameTeacher(String teacher_id) {
        for (String[] item : teachers) {
            if (item[2].equalsIgnoreCase(teacher_id)) {
                return item[0];
            }
        }
        return "error";
    }
}