CREATE DATABASE testdb; 

CREATE TABLE Course_Offered (
	courseOffer_id int NOT NULL , 
    teacher_id int NOT NULL, 
    is_active boolean NOT NULL,
    exam_date datetime NOT NULL,
    course_name  varchar(50) NOT NULL ,
    vahed int ,
    PRIMARY KEY (courseOffer),
    FOREIGN KEY (teacher_id) references Teacher(teacher_id)  
);


CREATE TABLE courseStudentPick (
	courseOffer_id int NOT NULL, 
    courseStu_pick int NOT NULL, 
    term_id int not null , 
    student_id int not null,
    grade int ,
    PRIMARY KEY (courseStu_pick),
    FOREIGN KEY (courseOffer_id) REFERENCES Course_Offered(courseOffer_id),
    foreign key (term_id) references Term(term_id),
    foreign key (student_id) references Student(student_id)
);


