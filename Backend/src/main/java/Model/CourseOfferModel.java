package Model;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class CourseOfferModel {
    private static final String FILE_PATH = "data/coursePresented.txt";
    private List<String[]> courses;

    public CourseOfferModel() {
        courses = new ArrayList<>();
        loadCourse();
    }

    private void loadCourse() {
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().indexOf('*') == 0) continue;
                String[] course_detail = line.split(",");
                courses.add(course_detail);
            }
        } catch (IOException e) {
            System.out.println("Error!!");
            e.printStackTrace();
        }
    }

    // fizik,1,9-10;
    public List<String> getCourse() {
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            List<String> list_course = new ArrayList<>();
            while ((line = reader.readLine()) != null) {
                if (line.trim().indexOf('*') == 0) continue;
                if (line.equals("\n")){
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