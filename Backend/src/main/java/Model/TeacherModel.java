package Model;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public  class TeacherModel{
    public boolean LoginTeacher(String username,String password){
        String file_path = "data/teacher.txt";
        try(BufferedReader br = new BufferedReader(new FileReader(file_path))){
            String line;
            while((line = br.readLine()) != null ){
                if(line.trim().startsWith("*")) continue;
                String[] teacher_detail = line.split(",");
                if(teacher_detail[0].equals(username) && teacher_detail[1].equals(password)){
                    return true;
                }

            }
            return false;
        }catch (IOException e) {
            System.out.println("Error!!");
            e.printStackTrace();
            return false;
        }
    }
}