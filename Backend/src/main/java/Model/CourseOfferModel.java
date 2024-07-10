package Model;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class CourseOfferModel {
    private static final String FILE_PATH = "data/coursePresented.txt";
    private List<String[]> courses;
    TeacherModel teacherModel = new TeacherModel();

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

    public Boolean AddCourseOfferToDataBase(String course_name, String teacher_name, String time, String vahed, String numOfAssign) {
        String id = String.valueOf(Integer.parseInt(courses.get(courses.size() - 1)[5]) + 1);
        String teacher_id = teacherModel.getTeacherId(teacher_name);
        String text = course_name + "," + teacher_id + "," + time + "," + vahed + "," + numOfAssign + "," + id;
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

    // fizik,1,9-10;
    public List<String> getCourse() {
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

    //    *name,teacher_id,time,vahed,numofassign,cpr_id
//    fizik,2,9-11,3,null,1
//    ap,1,12-3,3,null,2
    public String getDetailStdCourse(String id) {
        for (String[] item : courses) {
            if (item[5].equals(id)) {
                System.out.println(item[3]);
                return item[0] + "-" + item[2] + "-" + item[3] + "-" + item[4] + "-" + item[1];
            }
        }
        return "error-error";
    }
}