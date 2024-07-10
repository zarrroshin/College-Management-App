package Controller;

import Model.CourseOfferModel;
import Model.CourseStdModel;
import Model.StudentModel;
import Model.TeacherModel;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import java.util.List;

public class CourseController {

    CourseOfferModel model = new CourseOfferModel();
    TeacherModel teacherModel = new TeacherModel();
    CourseStdModel courseStdModel = new CourseStdModel();
    StudentModel studentModel = new StudentModel();
    CourseOfferModel courseOfferModel = new CourseOfferModel();

    public CourseController(CourseOfferModel model, TeacherModel teacherModel, CourseStdModel courseStdModel, StudentModel studentModel) {
        this.model = model;
        this.teacherModel = teacherModel;
        this.courseStdModel = courseStdModel;
        this.studentModel = studentModel;
    }

    //    *name,teacher_id,time,vahed,numofassign,cpr_id
//    fizik,2,9-11,3,null,1   -ap,1,12-3,3,null,2
    public boolean AddNewCourse(String course_name, String teacher_name, String time, String vahed, String numOfAssign) {
        return courseOfferModel.AddCourseOfferToDataBase(course_name, teacher_name, time, vahed, numOfAssign);
    }

    public JsonObject getCourseList() {
        List<String> list_course = model.getCourse();
        JsonObject response = new JsonObject();
        JsonArray ja = new JsonArray();
        for (String item : list_course) {
            String[] split_item = item.split(",");
            JsonObject course = new JsonObject();
            course.addProperty("name", split_item[0]);
            course.addProperty("time", split_item[2]);
            course.addProperty("vahed", split_item[3]);
            course.addProperty("numofassign", split_item[4]);
            course.addProperty("professor", teacherModel.getNameTeacher(split_item[1]));
            course.addProperty("cpr_id", split_item[5]);
            ja.add(course);
        }
        response.add("Courses", ja);
        return response;
    }
//    *cpr_id,stu_id,grade,cstd_id
//    1,     1234,   null,  1
//    1,     1246,   null,  2
//

    public JsonObject getStdCourseList(String username) {
        List<String> list_course = courseStdModel.getStdCourse();
        String student_id = studentModel.getStudentId(username);
        JsonObject response = new JsonObject();
        JsonArray ja = new JsonArray();
        for (String item : list_course) {
            System.out.println(item + "getStdcourselist");
            String[] split_item = item.split(",");
            if (split_item[1].equalsIgnoreCase(student_id)) {
                String cpr_id = split_item[0];
                JsonObject course = new JsonObject();
                String[] data = model.getDetailStdCourse(cpr_id).split("-");
                course.addProperty("name", data[0]);
                course.addProperty("time", data[1]);
                course.addProperty("vahed", data[2]);
                course.addProperty("numofassign", data[3]);
                course.addProperty("professor", teacherModel.getNameTeacher(data[4]));
                course.addProperty("cpr_id", cpr_id);
                ja.add(course);
            }

        }
        response.add("Courses", ja);
        return response;
    }

    public JsonObject AddToCourseStudent(String username, String cpr_id) {
        String student_id = studentModel.getStudentId(username);
        Boolean check = courseStdModel.AddStdCourseToDatabase(cpr_id, student_id);
        JsonObject response = new JsonObject();
        if (check) {
            response.addProperty("success", "taddaaaaa");
        } else {
            response.addProperty("error", "somthing went wrong!!! ");
        }
        return response;
    }

}
