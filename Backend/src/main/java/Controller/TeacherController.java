package Controller;

import Model.TeacherModel;


public class TeacherController {
    TeacherModel model ;

    public TeacherController(TeacherModel model){
        this.model = model ;
    }

    public Boolean checkLoginTeacher(String username , String password){
        return model.LoginTeacher(username, password);
    }
}
