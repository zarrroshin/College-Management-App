package Model;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class CourseStdModel {
    private static final String FILE_PATH = "data/coursestd.txt";
    private List<String[]> std_courses;

    public CourseStdModel() {
        std_courses = new ArrayList<>();
        loadStdCourse();
    }

    private void loadStdCourse() {
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().indexOf('*') == 0) continue;
                String[] course_detail = line.split(",");
                std_courses.add(course_detail);
            }
        } catch (IOException e) {
            System.out.println("Error!!");
            e.printStackTrace();
        }
    }

    public List<String> getStdCourse() {
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            List<String> list_course = new ArrayList<>();
            while ((line = reader.readLine()) != null) {
                if (line.trim().indexOf('*') == 0) continue;
                if (line.equals("\n")) {
                    continue;
                }
                list_course.add(line);
            }
            return list_course;
        } catch (IOException e) {
            System.out.println("Error!!");
            e.printStackTrace();
        }
        return null;
    }

}
