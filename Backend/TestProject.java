import java.util.*;

public class TestProject {
    public static void main(String[] args) {
        Student s1 = new Student(402243047, "kheiry");
        Student s2 = new Student(402243097, "Roshani");
        Student s3 = new Student(402243027, "alavi");
        Course math = new Course("Math", 3, true, "12-11-1384 12:00:00");
        Course ap = new Course("AP", 3, false, "12-11-1384 12:00:00");
        Course physics = new Course("Physics", 1, true, "12-11-1384 12:00:00");
        Assignment a1 = new Assignment(physics, "Assignment1", false, "12-11-2024 12:13:00");
        List<Course> ls = new ArrayList<Course>();
        ls.add(physics);
        ls.add(math);
        Teacher t1 = new Teacher("Ali", "Mohammadi", 2, ls);

        System.out.println("check different conditions of add student by teacher: ");
        t1.addStudent(s2, math);
        t1.addStudent(s1, ap);// Mohammadi doesn't teach AP
        t1.addStudent(s1, physics);
        t1.addStudent(s2, physics);
        physics.printStudents();
        t1.deleteStudent(s2, physics);
        physics.printStudents();

        System.out.println("check assignment methods:");
        a1.addToCourse(t1, physics);
        physics.printAssignment();
        a1.addToCourse(t1, ap);// Mohammadi doesn't teach AP
        t1.deleteAssignmentFromCourse(ap, a1);// AP doesn't have assignment:mini project

        System.out.println("check defineAssignment:");
        Assignment a2 = t1.defineAssignment(physics);// will ask q
        physics.printAssignment();// just line 22

        System.out.println("check deadline: ");
        System.out.println(a2.calculateTimeleft());

        System.out.println("check deleteAssignmentFromCourse:");
        t1.deleteAssignmentFromCourse(physics, a2);
        physics.printAssignment();

        System.out.println("check setGrades: ");
        t1.addStudent(s2, physics);
        physics.printStudents();
        t1.setGrades(physics);

        System.out.println("check findMaxGrade");
        System.out.println(physics.findMaxGrade());

        System.out.println("check changeDeadline ");
        physics.printAssignment();
        a1.changeDeadline(t1, physics);
        System.out.println(a1.calculateTimeleft());

        System.out.println("check addStudent and printCourses ");
        physics.addStudent(s3);
        math.addStudent(s3);
        s3.participateInCourse(ap);
        s3.printCourses();

        System.out.println("check printnumOfUnits");
        s3.printnumOfUnits();

        System.out.println("check printTotalAverage");
        t1.setGrades(physics);
        t1.setGrades(math);
        s3.printTotalAverage();
    }

}
