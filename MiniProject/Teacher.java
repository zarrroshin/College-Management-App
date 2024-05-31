import java.util.*;

public class Teacher {
    private String name;
    private String lastName;
    private int numOfpresent;
    private List<Course> presentcourses = new ArrayList<Course>();
    Scanner input = new Scanner(System.in);

    Teacher(String name, String lastName, int numOfpresent, List<Course> presentCourses) {
        this.name = name;
        this.lastName = lastName;
        this.numOfpresent = numOfpresent;
        this.presentcourses = presentCourses;

        // set teacher of each course in list
        for (int i = 0; i < presentCourses.size(); i++) {
            presentCourses.get(i).setTeacher(this);
        }
    }

    // each teacher can add student to his/her courses
    void addStudent(Student student, Course course) {
        if (presentcourses.contains(course) && course.getAvailability()) {
            course.addStudent(student);
            student.participateInCourse(course);
            System.out.println(
                    String.format("Student with id:%d added to course:%s", student.getStudentId(), course.getName()));

        }

        else if (!presentcourses.contains(course)) {
            System.out.println(String.format("%s doesn't teach %s", this.getLastName(), course.getName()));
        } else {
            System.out.println("this course is not available");
        }

    }

    // each teacher can remove student to his/her courses
    void deleteStudent(Student student, Course course) {
        if (presentcourses.contains(course) && course.getListOfStudents().contains(student)) {
            course.deleteStudent(student);
            student.deleteCourse(course);
            System.out.println(
                    String.format("Student with id:%d deleted from course:%s", student.getStudentId(),
                            course.getName()));

        }

        else if (!presentcourses.contains(course)) {
            System.out.println(String.format("%s doesn't teach %s", this.getLastName(), course.getName()));
        } else {
            System.out.println(String.format("The student with id:%d is not participating in this course",
                    student.getStudentId()));
        }
    }

    public Assignment defineAssignment(Course course) {
        if (presentcourses.contains(course)) {
            System.out.print("name: ");
            String name = input.nextLine();
            System.out.print("availability(true/false): ");
            boolean availability = input.nextBoolean();
            System.out.print("please enter deadline of assignment in dd-MM-yyyy HH:mm:ss\n");
            input.nextLine();
            String string = input.nextLine();
            Assignment assignment = new Assignment(course, name, availability, string);
            course.addAssignment(assignment);
            return assignment;
        } else {
            System.out.println(String.format("%s doesn't teach %s", this.getLastName(), course.getName()));
            return null;
        }
    }

    public void deleteAssignmentFromCourse(Course course, Assignment assignment) {
        if (presentcourses.contains(course)) {
            if (course.getAssignments().contains(assignment)) {
                course.deleteAssignment(assignment);
                assignment = null;
            } else {
                System.out.printf("The assignment:%s is not in this course\n", assignment.getName());
            }
        } else {
            System.out.println(String.format("%s doesn't have assignment:%s", course.getName(), assignment.getName()));
        }
    }

    public void setGrades(Course course) {
        for (int i = 0; i < course.getNumOfStudents(); i++) {
            System.out.printf("please enter the grade of Student:%d in %s\n",
                    course.getListOfStudents().get(i).getStudentId(), course.getName());
            int grade = input.nextInt();
            course.getListOfStudents().get(i).setGrade(course, grade);
        }
    }

    public String getLastName() {
        return lastName;
    }

    public List<Course> getPresentcourses() {
        return presentcourses;
    }
}