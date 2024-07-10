package Model;

import java.io.*;
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

    public Boolean AddStdCourseToDatabase(String cpr_id, String student_id) {
        String cstd_id = String.valueOf(Integer.parseInt(std_courses.get(std_courses.size() - 1)[3]) + 1);
        String text = cpr_id + "," + student_id + "," + "null" + "," + cstd_id;

        try {
            BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true));
            writer.newLine();
            writer.write(text);
            writer.close();
            return true;
        } catch (IOException ioe) {
            System.out.println("Something Went Wrong Please try again!!!");
            ioe.printStackTrace();
            return false;
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
