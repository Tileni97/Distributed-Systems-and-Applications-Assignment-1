import ballerina/io;
import ballerina/http;

public type Lecturer record {
    string staff_number;
    string name;
    string title;
    string office_number;
    string course;
    string telephone;
    string email;
};

public function main() returns error? {
    
    http:Client universityClient = check new ("localhost:9090/university_management");

    io:println("1. Add a new Lecturer.");
    io:println("2. Show list of all lecturers within the faculty.");
    io:println("3. Edit an existing lecturer's information.");
    io:println("4. Search lecturer by their staff number.");
    io:println("5. Delete lecturer by their staff number.");
    io:println("6. Show all lecturers lecturing the same course");
    io:println("7. Show all lecturers sitting in the same office");

    string option = io:readln("Choose an option: ");

    match option {
        "1" => {
            Lecturer lecturerDetails = {office_number: "", name: "", course: "", telephone: "", title: "", email: "", staff_number: ""};

        lecturerDetails.staff_number = io:readln("Enter the staff number: ");
        lecturerDetails.name = io:readln("Enter the name: ");
        lecturerDetails.title = io:readln("Enter the title: ");
        lecturerDetails.office_number = io:readln("Enter the office number: ");
        lecturerDetails.course = io:readln("Enter the course: ");
        lecturerDetails.telephone = io:readln("Enter the telephone: ");
        lecturerDetails.email = io:readln("Enter the email: ");

        lecturerDetails = {office_number: lecturerDetails.office_number, name: lecturerDetails.name, course: lecturerDetails.course, telephone: lecturerDetails.telephone, title: lecturerDetails.title, email: lecturerDetails.email, staff_number: lecturerDetails.staff_number};

        check create(universityClient, lecturerDetails);
        }
        "3" => {
            Lecturer lecturerDetails = {office_number: "", name: "", course: "", telephone: "", title: "", email: "", staff_number: ""};
            lecturerDetails.staff_number = io:readln("Enter the staff number: ");
            lecturerDetails.name = io:readln("Enter the name: ");
            lecturerDetails.title = io:readln("Enter the title: ");
            lecturerDetails.office_number = io:readln("Enter the office number: ");
            lecturerDetails.course = io:readln("Enter the course: ");
            lecturerDetails.telephone = io:readln("Enter the telephone: ");
            lecturerDetails.email = io:readln("Enter the email: ");
            check update(universityClient, lecturerDetails);
        }
        "5" => {
            string staffNo = io:readln("Enter the staff number: ");
            check delete(universityClient,staffNo);
        }
        "2" => {
            check getAll(universityClient);
        }
        "4" => {
            string staffNo = io:readln("Enter the staff number: ");
            check getByCode(universityClient,staffNo);
        }
        "6" => {
            string courseName = io:readln("Enter course Name: ");
            check getByCourse(universityClient, courseName);
        }
        "7" => {
            string officeNo = io:readln("Enter office number: ");
            check getByOffieNo(universityClient, officeNo);
        }
        _ => {
            io:println("Invalid Key");
            check main();
        }
    }
}

// Function to create a course

public function create(http:Client http, Lecturer newLecturer) returns error? {
    if (http is http:Client) {
        http:Response|error response = check http->/university_management/lecturers.post(newLecturer);
        
        if (response is http:Response) {
            if (response.statusCode == 201) {
                io:println("Lecturer with staff number " + newLecturer.staff_number + " has been created successfully.");
            } else {
                io:println("Error creating lecturer with staff number " + newLecturer.staff_number);
            }
        } else {
            io:println("Error creating lecturer with staff number " + newLecturer.staff_number);
        }

        string exit = io:readln("Enter 0 to go back: ");

        if (exit == "0") {
            error? mainResult = main();
            if mainResult is error {
                io:println("Error, sorry you cannot go back.");
            }
        }
    }
}

public function creat(http:Client http, Lecturer newLecturer) returns error? {
    if (http is http:Client) {
        string message = check http->/lecturers.post(newLecturer);
        io:println(message);
        string exit = io:readln("Enter 0 to go back: ");

        if (exit == "0") {
            error? mainResult = main();
            if mainResult is error {
                io:println("Error, sorry you can not go back..");
            }
        }
    }
}

public function update(http:Client http, Lecturer editLecturer) returns error? {
    string create = check http->/lecturers/staff_number.put(editLecturer);
    io:println(create);
}


public function delete(http:Client http, string staff_number) returns error? {
    if (http is http:Client) {
        
        
        Lecturer[] id = check http->/lecturers/staff_number/[staff_number].delete({staff_number});

        foreach Lecturer item in id {

            if ( item.name.length()== 0) {
                io:println("Not matched");
                string exit = io:readln("Press 0 to go back: ");
                if (exit == "0") {
                    return ();
                }
       
            } else {

            io:println("--------------------------");
            io:println("Lecturer with staff number: ", item.staff_number, " successfully deleted!");
            io:println("Staff number: ", item.staff_number);
            io:println("Name: ", item.name);
            io:println("Title: ", item.title);
            io:println("Office number: ", item.office_number);
            io:println("Course: ", item.course);
            io:println("Telephone: ", item.telephone);
            io:println("Email: ", item.email);
           
            }
        
        }

        
    }
}

public function getAll(http:Client http) returns error? {
    if (http is http:Client) {
        Lecturer[] lecturers = check http->/lecturers;
        foreach Lecturer item in lecturers {
            io:println("--------------------------");
            io:println("Staff number: ", item.staff_number);
            io:println("Name: ", item.name);
            io:println("Title: ", item.title);
            io:println("Office number: ", item.office_number);
            io:println("Course: ", item.course);
            io:println("Telephone: ", item.telephone);
            io:println("Email: ", item.email);
        }

        io:println("--------------------------");
        string exit = io:readln("Press 0 to go back: ");

        if (exit == "0") {
            error? mainResult = main();
            if mainResult is error {
                io:println("Error, sorry you can not go back.");
            }
        }
    }
}



public function getByCode(http:Client http, string staffNo) returns error? {
    if (http is http:Client) {
        Lecturer[] id = check http->/lecturers/staff_number/[staffNo];

        foreach Lecturer item in id {

            if ( item.name.length()== 0) {
                io:println("Not matched");
                string exit = io:readln("Press 0 to go back: ");
                if (exit == "0") {
                    return ();
                }
       
            } else {

            io:println("--------------------------");
            io:println("Staff number: ", item.staff_number);
            io:println("Name: ", item.name);
            io:println("Title: ", item.title);
            io:println("Office number: ", item.office_number);
            io:println("Course: ", item.course);
            io:println("Telephone: ", item.telephone);
            io:println("Email: ", item.email);
            if item.staff_number.length() is 0 {
                break;
            }
            }
        
        }

        io:println("--------------------------");
        string exit = io:readln("Press 0 to go back: ");
    
        if (exit == "0") {
            error? mainResult = main();
            if mainResult is error {
                io:println("Error, sorry you can not go back.");
                return mainResult;
            }
        }
    }
}

public function getByCourse(http:Client http, string courseName) returns error? {
    if (http is http:Client) {
        Lecturer[] course = check http->/lecturers/course/[courseName];

        foreach Lecturer item in course {

            if ( item.name.length()== 0) {
                io:println("Not matched");
                string exit = io:readln("Press 0 to go back: ");
                if (exit == "0") {
                    return ();
                }
       
            } else {

            io:println("--------------------------");
            io:println("Staff number: ", item.staff_number);
            io:println("Name: ", item.name);
            io:println("Title: ", item.title);
            io:println("Office number: ", item.office_number);
            io:println("Course: ", item.course);
            io:println("Telephone: ", item.telephone);
            io:println("Email: ", item.email);
            }
        
        }

        io:println("--------------------------");
        string exit = io:readln("Press 0 to go back: ");
    
        if (exit == "0") {
            error? mainResult = main();
            if mainResult is error {
                io:println("Error, sorry you can not go back.");
                return mainResult;
            }
        }
    }
}


public function getByOffieNo(http:Client http, string officeNo) returns error? {
    if (http is http:Client) {
        Lecturer[] office = check http->/lecturers/office_number/[officeNo];

        foreach Lecturer item in office {

            if ( item.name.length()== 0) {
                io:println("Not matched");
                string exit = io:readln("Press 0 to go back: ");
                if (exit == "0") {
                    return check main();
                }
       
            } else {

            io:println("--------------------------");
            io:println("Staff number: ", item.staff_number);
            io:println("Name: ", item.name);
            io:println("Title: ", item.title);
            io:println("Office number: ", item.office_number);
            io:println("Course: ", item.course);
            io:println("Telephone: ", item.telephone);
            io:println("Email: ", item.email);
            }
        
        }

        io:println("--------------------------");
        string exit = io:readln("Press 0 to go back: ");
    
        if (exit == "0") {
            error? mainResult = main();
            if mainResult is error {
                io:println("Error, sorry you can not go back.");
                return mainResult;
            }
        }
    }
}

