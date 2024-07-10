package Model;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public  class TeacherModel {
    public boolean LoginTeacher(String username, String password) {
        String file_path = "data/teacher.txt";
        try (BufferedReader br = new BufferedReader(new FileReader(file_path))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.trim().startsWith("*")) continue;
                String[] teacher_detail = line.split(",");
                if (teacher_detail[0].equals(username) && teacher_detail[1].equals(password)) {

                    return true;
                }

            }
            return false;
        } catch (IOException e) {
            System.out.println("Error!!");
            e.printStackTrace();
            return false;
        }

    }


    public int SetGrade(String username, String studentId, String courseId, String grade) {
        String CoursePresentedFile = "data/coursePresented.txt";
        String CourseStudentFile = "data/coursestd.txt";

        try (BufferedReader br = new BufferedReader(new FileReader(CoursePresentedFile))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.trim().startsWith("*")) continue;
                String[] course_detail = line.split(",");
                if (course_detail[5].equals(courseId)&&course_detail[1].equals(username)) {
                    try (BufferedReader br2 = new BufferedReader(new FileReader(CourseStudentFile))) {
                        String line2;
                        List<String> lines = new ArrayList<>();
                        while ((line2 = br2.readLine()) != null) {
                            lines.add(line2);
                        }
                        try (BufferedWriter br3 = new BufferedWriter(new FileWriter(CourseStudentFile))) {
                            for (String s : lines) {
                                String[] coursestd_detail = s.split(",");
                                if(s.startsWith("*")) {
                                    br3.write(s);
                                }
                                else if (coursestd_detail[1].equals(studentId)) {
                                    coursestd_detail[2] = grade;
                                    String str = "\n" +coursestd_detail[0] + ',' + coursestd_detail[1] + ',' + coursestd_detail[2] + ',' + coursestd_detail[3];
                                    br3.write(str);
                                } else {
                                    br3.write("\n"+s);
                                }}

                                return 200;//teacher doesn't offer this course
                            } catch (IOException a) {
                                System.out.println("Error!!");
                                a.printStackTrace();
                                return 300;//Error
                            }


                    }catch(Exception e){
                        System.out.println("Error!!");
                        e.printStackTrace();
                        return 400;//Error}


                    }
                }
                return 500;//student doesn't atttend this cpurse
            }
        return 600;//teacher doesn't offer this course
    }catch(Exception e){
        System.out.println("Error!!");
        e.printStackTrace();
        return 700;//Error
    }
}


    public boolean DefineAssignmentTeacher(String cpr_id,String name ,String is_active,String deadline){
        String file_path = "data/assignment.txt";
        try (BufferedWriter br3 = new BufferedWriter(new FileWriter(file_path,true))) {
            List<String> lines = new ArrayList<>();
            try (BufferedReader reader = new BufferedReader(new FileReader(file_path))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    lines.add(line);
                }
                int currentLineNumber = lines.size();
                String line2 = '\n'+name+','+deadline+','+is_active+','+cpr_id+','+(currentLineNumber+1);
                br3.write(line2);
                return true;

            } catch (IOException a) {
                System.out.println("Error!!");
                a.printStackTrace();
                return false;//Error
            }




        } catch (IOException a) {
            System.out.println("Error!!");
            a.printStackTrace();
            return false;//Error
        }

    }

    public boolean DeleteAssignment(String cpr_id,String name){
        String file_path = "data/assignment.txt";
        try (BufferedReader br2 = new BufferedReader(new FileReader(file_path))) {
            String line2;
            List<String> lines = new ArrayList<>();
            while ((line2 = br2.readLine()) != null) {
                lines.add(line2);
            }
            try (BufferedWriter br3 = new BufferedWriter(new FileWriter(file_path))) {
                for (String s : lines) {
                    String[] assignment_detail = s.split(",");
                    if(s.startsWith("*")) {
                        br3.write(s);
                    }
                    else if (assignment_detail[0].equals(name)&&assignment_detail[3].equals(cpr_id)) {
                    } else {
                        br3.write("\n"+s);
                    }}

                return true;
            } catch (IOException a) {
                System.out.println("Error!!");
                a.printStackTrace();
                return false;//Error
            }


        }catch(Exception e){
            System.out.println("Error!!");
            e.printStackTrace();
            return false;//Error}



    }}

}