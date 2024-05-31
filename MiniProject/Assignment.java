import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class Assignment {
    private String name;
    private LocalDateTime deadline;
    private boolean availability;
    private Course course;
    Scanner input = new Scanner(System.in);

    Assignment(Course course, String name, boolean availability, String deadline) {
        this.name = name;
        this.availability = availability;
        this.course = course;
        setDeadline(deadline);

    }

    public boolean getAvailability() {
        return availability;
    }

    public String getName() {
        return name;
    }

    public String calculateTimeleft() {
        LocalDateTime now = LocalDateTime.now();
        Duration diff = Duration.between(now, this.deadline);
        return format(diff);
    }

    // this method uses Duration methods for converting Duration class to String
    public static String format(Duration d) {
        long days = d.toDays();
        d = d.minusDays(days);
        long hours = d.toHours();
        d = d.minusHours(hours);
        long minutes = d.toMinutes();
        d = d.minusMinutes(minutes);
        long seconds = d.getSeconds();
        return (days == 0 ? "" : days + " days,") +
                (hours == 0 ? "" : hours + " hours,") +
                (minutes == 0 ? "" : minutes + " minutes,") +
                (seconds == 0 ? "" : seconds + " seconds left");
    }

    public void setDeadline(String dateOfExam) {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        LocalDateTime time = LocalDateTime.parse(dateOfExam, dtf);
        this.deadline = time;
    }

    public void addToCourse(Teacher teacher, Course course) {
        if (teacher.getPresentcourses().contains(course)) {
            course.addAssignment(this);
        } else {
            System.out.printf("%s doesn't teach %s\n", teacher.getLastName(), course.getName());
        }
    }

    public void deleteFromCourse(Teacher teacher, Course course) {
        if (teacher.getPresentcourses().contains(course)) {
            course.deleteAssignment(this);
        } else {
            System.out.printf("%s doesn't teach %s\n", teacher.getLastName(), course.getName());
        }
    }

    public void changeDeadline(Teacher teacher, Course course) {
        if (teacher.getPresentcourses().contains(course)) {
            System.out.printf("please enter deadline of assignment:%s in dd-MM-yyyy HH:mm:ss\n", this.name);
            String string = input.nextLine();
            this.setDeadline(string);
        } else {
            System.out.printf("%s doesn't teach %s\n", teacher.getLastName(), course.getName());
        }

    }

    public Course getCourse() {
        return course;
    }

}
