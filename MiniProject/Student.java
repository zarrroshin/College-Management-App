import java.util.ArrayList;
import java.util.*;

public class Student {
    private String lastName;
    private int studentId;
    private int numOfCourses;
    private int numberOfUnits;
    private Map<Course, Integer> courseAndNumbers = new HashMap<Course, Integer>();
    private int totalAverage;
    private int averageOfSemester;

    Student(int studentId, String lastName) {
        this.studentId = studentId;
        this.lastName = lastName;
    }

    public void participateInCourse(Course course) {
        courseAndNumbers.put(course, null);
        numOfCourses++;
        numberOfUnits += course.getNumOfunitOfCourse();

    }

    public void deleteCourse(Course course) {
        courseAndNumbers.remove(course);
        numOfCourses--;
        numberOfUnits -= course.getNumOfunitOfCourse();
    }

    public int getStudentId() {
        return studentId;
    }

    public void setGrade(Course course, int grade) {
        courseAndNumbers.replace(course, grade);
        // averageOfSemester
    }

    public Map<Course, Integer> getCourseAndNumbers() {
        return courseAndNumbers;
    }

    public void printCourses() {
        courseAndNumbers.forEach((k, v) -> {
            System.out.println(k.getName());
        });
    }

    public void printTotalAverage() {
        int sum = 0;
        int count = 0;
        for (Integer value : courseAndNumbers.values()) {
            if (value != null) {

                sum += value;
                count++;
            }
        }
        totalAverage = sum / count;
        System.out.printf("Total average is %d\n", this.totalAverage);
    }

    public void printnumOfUnits() {
        System.out.printf("number of units are:%d\n", this.numberOfUnits);
    }

    public String getLastName() {
        return lastName;
    }
}
