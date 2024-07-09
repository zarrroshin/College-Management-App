package Controller;

import Model.CourseOfferModel;
import Model.TeacherModel;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import java.util.List;

public class CourseController {

    CourseOfferModel model = new CourseOfferModel();
    TeacherModel teacherModel = new TeacherModel();

    public CourseController(CourseOfferModel model, TeacherModel teacherModel) {
        this.model = model;
        this.teacherModel = teacherModel;
    }
//    *name,teacher_id,time,vahed,numofassign,cpr_id
//    fizik,2,9-11,3,null,1   -ap,1,12-3,3,null,2

    public JsonObject getCourseList() {
        List<String> list_course = model.getCourse();
        JsonObject response = new JsonObject();
        JsonArray ja = new JsonArray();
        for (String item : list_course) {
            System.out.println(item+"getcourselist");
            String[] split_item = item.split(",");
            JsonObject course = new JsonObject();
            course.addProperty("name", split_item[0]);
            course.addProperty("time", split_item[2]);
            course.addProperty("vahed", split_item[3]);
            course.addProperty("numofassign", split_item[4]);
            course.addProperty("professor", teacherModel.getNameTeacher(split_item[1]));
            course.addProperty("cpr_id",split_item[5]);
            ja.add(course);
        }
        response.add("Courses", ja);
        return response;
    }

}
