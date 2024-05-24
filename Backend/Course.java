import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.time.LocalDateTime;
import java.time.format.*;

public class Course {
    private String name;
    private Teacher teacher;
    private int numOfunitOfCourse;
    private List<Student> listOfStudents = new ArrayList<Student>();
    private boolean availability;
    private List<Assignment> assignments = new ArrayList<Assignment>();
    private int numOfAssignments;
    private LocalDateTime dateOfExam;
    private List<Assignment> availableProjects = new ArrayList<Assignment>();
    private List<Assignment> unavailableProjects = new ArrayList<Assignment>();
    private int numOfStudents;
    Scanner input = new Scanner(System.in);

    // creat a course with features which are constant between different teachers
    Course(String name, int numOfunitOfCourse, boolean availability, String string) {
        this.name = name;
        this.numOfunitOfCourse = numOfunitOfCourse;
        this.availability = availability;
        setExamTime(string);

    }

    public void setExamTime(String dateOfExam) {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        LocalDateTime time = LocalDateTime.parse(dateOfExam, dtf);
        this.dateOfExam = time;
    }

    public void addStudent(Student student) {
        listOfStudents.add(student);
        numOfStudents++;
        student.participateInCourse(this);

    }

    public void deleteStudent(Student student) {
        listOfStudents.remove(student);
        numOfStudents--;
        student.deleteCourse(this);

    }

    public void addAssignment(Assignment assignment) {
        assignments.add(assignment);
        numOfAssignments++;
        if (assignment.getAvailability()) {
            availableProjects.add(assignment);
        } else {
            unavailableProjects.add(assignment);
        }
    }

    public void deleteAssignment(Assignment assignment) {
        assignments.remove(assignment);
        numOfAssignments--;
    }

    public void printStudents() {
        for (int i = 0; i < listOfStudents.size(); i++) {
            System.out.println(
                    String.format("%s:%d", listOfStudents.get(i).getLastName(), listOfStudents.get(i).getStudentId()));

        }
    }

    public int findMaxGrade() {
        int max = 0;
        for (int i = 0; i < listOfStudents.size(); i++) {
            int grade = listOfStudents.get(i).getCourseAndNumbers().get(this);
            if (grade > max) {
                max = grade;
            }
        }
        return max;
    }

    public void printAssignment() {
        for (int i = 0; i < assignments.size(); i++) {
            System.out.println(assignments.get(i).getName());
        }
    }

    public String getName() {
        return name;
    }

    public int getNumOfunitOfCourse() {
        return numOfunitOfCourse;
    }

    public boolean getAvailability() {
        return availability;
    }

    public List<Student> getListOfStudents() {
        return listOfStudents;
    }

    public List<Assignment> getAssignments() {
        return assignments;
    }

    public int getNumOfStudents() {
        return numOfStudents;
    }

    public void setTeacher(Teacher teacher) {
        this.teacher = teacher;
    }

    public void setAvailability(boolean availability) {
        this.availability = availability;
    }

}
