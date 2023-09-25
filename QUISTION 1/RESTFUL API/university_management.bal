import ballerina/http;

type Lecturer record {|
    readonly string staff_number;
    string name;
    string title;
    string office_number;
    string course;
    string telephone;
    string email;
|};

table<Lecturer> key(staff_number) lecturers = table[
    {staff_number: "1", name: "John",title: "Mr", office_number: "100",course: "DPG", telephone: "06177864", email: "johnpeya@nust.na"},
    {staff_number: "2", name: "Gin",title: "Mr", office_number: "101",course: "WAD", telephone: "06177865", email: "gin@nust.na"},
    {staff_number: "3", name: "Nob",title: "Mr", office_number: "101",course: "WAD", telephone: "06178865", email: "nob@nust.na"},
    {staff_number: "4", name: "Grill",title: "Mr", office_number: "102",course: "SDN", telephone: "06171165", email: "grill@nust.na"},
    {staff_number: "5", name: "Jolly",title: "Mrs", office_number: "103",course: "DSA", telephone: "06170065", email: "jolly@nust.na"},
    {staff_number: "6", name: "Joana",title: "Mrs", office_number: "104",course: "PRG", telephone: "06177975", email: "joana@nust.na"},
    {staff_number: "7", name: "Kelly",title: "Mrs", office_number: "104",course: "PRG", telephone: "06177970", email: "kelly@nust.na"}
];


type ErrorDetails record {
    string message;
    
};

type LecturerNotFound record {|
    *http:NotFound;
    ErrorDetails body;

|}; 


type ErrorMsg record {
    string errmsg;
};

type ConflictingStaffNumberError record {|
    *http:Conflict;
    ErrorMsg body;
|};

//********************************/university_management*************************************
service /university_management on new http:Listener(9090) {


    //*************************************GET FUNTIONS******************************************
    //***************************/university_management/lecturers********************************
    resource function get lecturers() returns Lecturer[] | error {
        return lecturers.toArray(); //Retrieve all lecturers in the faculty
    }


    //**********************/university_management/lecturers/staff_number************************
    resource function get lecturers/staff_number/[string staff_number]() returns Lecturer[]|LecturerNotFound {
        Lecturer[] matchingstaff = [];
        foreach var lecturer in lecturers.toArray() {
            if(lecturer.staff_number == staff_number) {
                matchingstaff.push(lecturer);
            }
            
        }
        if (matchingstaff.length() == 0) {
            LecturerNotFound missing = {
                body: {message: "The specified Staff Number does not match any Lecturer, please specify a valid Staff Number"}
            };
            return missing;
        }

        return matchingstaff;
    
    }


    //**********************/university_management/lecturers/course************************
    resource function get lecturers/course/[string course]() returns Lecturer[] | LecturerNotFound {
       Lecturer[] matchingLecturers = [];
        foreach var lecturer in lecturers.toArray() {
            if (lecturer.course == course) {
                matchingLecturers.push(lecturer);
            }
        }
        if (matchingLecturers.length() == 0) {
            LecturerNotFound missing = {
                body: {message: "The specified Course does not match any Lecturer, please specify a valid Course"}
            };
            return missing;
        }
        return matchingLecturers;
    }


     //**********************/university_management/lecturers/office_number************************
    resource function get lecturers/office_number/[string office_number]() returns Lecturer[] | LecturerNotFound {
       Lecturer[] matchingLecturers = [];
        foreach var lecturer in lecturers.toArray() {
            if (lecturer.office_number == office_number) {
                matchingLecturers.push(lecturer);
            }
        }
        if (matchingLecturers.length() == 0) {
            LecturerNotFound missing = {
                body: {message: "The specified Office Number does not match any Lecturer, please specify a valid Office Number"}
            };
            return missing;
        }
        return matchingLecturers;
    }

  
  resource function post lecturers(@http:Payload Lecturer[] newLecturer) returns Lecturer[]|ConflictingStaffNumberError {

    string[] conflictingStaffNo = from Lecturer lecturerEntry in newLecturer
        where lecturers.hasKey(lecturerEntry.staff_number)
        select lecturerEntry.staff_number.toString();

        if conflictingStaffNo.length() > 0 {
            return {
                body: {
                    errmsg: string:'join(" ", "Conflicting Staff Number:", ...conflictingStaffNo)
                }
            };
        } else {
            newLecturer.forEach(lecturerEntry => lecturers.add(lecturerEntry));
            return newLecturer;
        }
    }

    resource function delete lecturers/staff_number/[string staff_number]() returns Lecturer|LecturerNotFound {
    // Check if the staff_number exists in the lecturers table
    
    Lecturer matchingStaff = {office_number: "", name: "", course: "", telephone: "", title: "", email: "", staff_number: ""};
    boolean isFound = false;
    
    foreach var lecturer in lecturers.toArray() {
        if (lecturer.staff_number == staff_number) {
            matchingStaff = lecturer;
            isFound = true;
            break;
        }
    }
    
    if (!isFound) {
        LecturerNotFound notFoundError = {
            body: {message: "The specified Staff Number does not match any Lecturer, please specify a valid Staff Number"}
        };
        return notFoundError;
    }
    
    // Delete the matching lecturer from the server here
    if (lecturers.hasKey(staff_number)) {
            Lecturer removedLecturer = lecturers.remove(staff_number);
            return removedLecturer;
        }
    
    return matchingStaff;
}



    resource function put lecturers/staff_number/[string staff_number](Lecturer updatedLecturer) returns Lecturer|LecturerNotFound {
        // Check if the staff_number exists in the lecturers table
        if (lecturers.hasKey(staff_number)) {
            // Retrieve the existing lecturer
            Lecturer existingLecturer = <Lecturer>lecturers[staff_number];
            
            // Update the lecturer's information
            existingLecturer.name = updatedLecturer.name;
            existingLecturer.title = updatedLecturer.title;
            existingLecturer.office_number = updatedLecturer.office_number;
            existingLecturer.course = updatedLecturer.course;
            existingLecturer.telephone = updatedLecturer.telephone;
            existingLecturer.email = updatedLecturer.email;
    
            // Return the updated lecturer
            return existingLecturer;
        } 
        else {
            // If the staff_number does not exist, return an error message
            LecturerNotFound notFoundError = {
                body: {message: "Lecturer not found for the specified Staff Number"}
            };
            return notFoundError;
        }
    }
}
