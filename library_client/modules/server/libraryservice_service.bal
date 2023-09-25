import ballerina/grpc;
import ballerina/log;

public const string LIBRARY_DESC = "0A0D6C6962726172792E70726F746F22A5010A04426F6F6B12120A046973626E18012001280952046973626E12140A057469746C6518022001280952057469746C6512190A08617574686F725F311803200128095207617574686F723112190A08617574686F725F321804200128095207617574686F7232121A0A086C6F636174696F6E18052001280952086C6F636174696F6E12210A0C69735F617661696C61626C65180620012808520B6973417661696C61626C65223C0A045573657212170A07757365725F69641801200128095206757365724964121B0A09757365725F7479706518022001280952087573657254797065224E0A0E416464426F6F6B5265717565737412210A0C757365725F70726F66696C65180120012809520B7573657250726F66696C6512190A04626F6F6B18022001280B32052E426F6F6B5204626F6F6B22250A0F416464426F6F6B526573706F6E736512120A046973626E18012001280952046973626E22310A12437265617465557365727352657175657374121B0A05757365727318012003280B32052E557365725205757365727322320A134372656174655573657273526573706F6E7365121B0A05757365727318012003280B32052E5573657252057573657273222E0A11557064617465426F6F6B5265717565737412190A04626F6F6B18012001280B32052E426F6F6B5204626F6F6B223E0A12557064617465426F6F6B526573706F6E736512280A0C757064617465645F626F6F6B18012001280B32052E426F6F6B520B75706461746564426F6F6B22270A1152656D6F7665426F6F6B5265717565737412120A046973626E18012001280952046973626E22310A1252656D6F7665426F6F6B526573706F6E7365121B0A05626F6F6B7318012003280B32052E426F6F6B5205626F6F6B7322360A194C697374417661696C61626C65426F6F6B735265717565737412190A047573657218012001280B32052E5573657252047573657222390A1A4C697374417661696C61626C65426F6F6B73526573706F6E7365121B0A05626F6F6B7318012003280B32052E426F6F6B5205626F6F6B7322270A114C6F63617465426F6F6B5265717565737412120A046973626E18012001280952046973626E22300A124C6F63617465426F6F6B526573706F6E7365121A0A086C6F636174696F6E18012001280952086C6F636174696F6E224B0A11426F72726F77426F6F6B5265717565737412190A047573657218012001280B32052E55736572520475736572121B0A09626F6F6B5F6973626E1802200128095208626F6F6B4973626E222E0A12426F72726F77426F6F6B526573706F6E736512180A077375636365737318012001280852077375636365737332A3030A0E4C69627261727953657276696365122C0A07416464426F6F6B120F2E416464426F6F6B526571756573741A102E416464426F6F6B526573706F6E736512380A0B437265617465557365727312132E4372656174655573657273526571756573741A142E4372656174655573657273526573706F6E736512350A0A557064617465426F6F6B12122E557064617465426F6F6B526571756573741A132E557064617465426F6F6B526573706F6E736512350A0A52656D6F7665426F6F6B12122E52656D6F7665426F6F6B526571756573741A132E52656D6F7665426F6F6B526573706F6E7365124D0A124C697374417661696C61626C65426F6F6B73121A2E4C697374417661696C61626C65426F6F6B73526571756573741A1B2E4C697374417661696C61626C65426F6F6B73526573706F6E736512350A0A4C6F63617465426F6F6B12122E4C6F63617465426F6F6B526571756573741A132E4C6F63617465426F6F6B526573706F6E736512350A0A426F72726F77426F6F6B12122E426F72726F77426F6F6B526571756573741A132E426F72726F77426F6F6B526573706F6E7365620670726F746F33";




public function main() {
    log:printInfo("Starting program...");
    // Your program code goes here
    log:printInfo("Program finished.");
}

type BookJson record {|
    string bookId;
    string title;
    string author_1;
    string author_2;
    string location;
    string isbn= "";
    boolean status;
|};
enum UserProfile {
    STUDENT = "STUDENT",
    LIBRARIAN = "LIBRARIAN"
};


table<User> usersTable = table[];


map<json> library = {};

map<BorrowedBook> borrowedBooksMap = {};


// Define a record to represent a borrowed book
type BorrowedBook record {
    string userId;
    string isbn;
};

listener grpc:Listener ep = new (9090); //

@grpc:Descriptor {value: LIBRARY_DESC}
service "LibraryService" on ep {


remote function AddBook(BookJson bookJson) returns string | error {
    // Access the user profile from the context
    User? user = getAuthenticatedUser();
        
    // Check if the user is a librarian
    if (user != null && user.profile == "LIBRARIAN")  {
        // User is a librarian, proceed with book addition

        // Generate a unique ISBN (e.g., use UUID generator)
        string generatedIsbn = generateUniqueIsbn();
        
        // Create a JSON object representing the book
        json bookObject = {
            "title": bookJson.title,
            "author_1": bookJson.author_1,
            "location": bookJson.location,
            "isbn": generatedIsbn,
            "status": true
        };
        
        // Store the book JSON object in the library map
        library[generatedIsbn] = bookObject;

        // Return the ISBN of the added book
        return generatedIsbn;
    } else {
        // User is not a librarian, return an error
        error customError = LibraryError("Only librarians are allowed to add books.");
        return customError;
    }
}

   remote function CreateUsers(CreateUsersRequest value) returns CreateUsersResponse|error {
    // Create a response message to hold the result
    CreateUsersResponse response = {};

    // Iterate through each element inside `users` array and create a new entry for it into the database
    foreach var user in value.users {
        // Generate a unique user ID (e.g., use UUID generator)
        string generatedUserId = generateUniqueUserId();

        // Create a new user object based on the profile specified in the request
        User newUser = {
            userId: generatedUserId,
            profile: user.profile
        };

       error? updateResult = usersTable.put(newUser);
        
        // Check if updateResult is an error
        if (updateResult is error) {
            // Handle the error by logging a message and returning an error response
            log:printError("Error occurred while adding user: " + updateResult.toString());
            // You can create and return a custom error response here if needed
            return error("Failed to add user");
        }
    }

    // Return the response indicating the success of the operation
    return response;
}

 remote function UpdateBook(UpdateBookRequest value) returns UpdateBookResponse|error {
    // Access the user profile from the context
    User? user = getAuthenticatedUser();
        
    // Check if the user is a librarian
    if (user?.profile == "LIBRARIAN") {
        // Get the requested book from the library using its ISBN as the key
        var book = library[value.isbn];

        // Check if the book exists in the library
        if (book != ()) {
            // Create a new JSON object with the updated values
            json updatedBook = {
                "title": value.title,
                "author_1": value.author_1,
                "author_2": value.author_2,
                "location": value.location
            };

            // Store the updated book back in the library
            library[value.isbn] = updatedBook;

            // Return a success response
            UpdateBookResponse response = { updated: true };
            return response;
        } else {
            // Book with the given ISBN doesn't exist, return an error
            return error("Book not found");
        }
    } else {
        // User is not a librarian, return an error
        return error("Only librarians are allowed to update books.");
    }
}

remote function RemoveBook(RemoveBookRequest value) returns RemoveBookResponse|error {
    // Access the user profile from the context
    User? user = getAuthenticatedUser();

    // Check if the user is a librarian
    if (user?.profile == "LIBRARIAN") {
        // Check if the ISBN in the request is valid
        string? isbn = value.isbn;
        if (isbn == null) {
            return error("Invalid ISBN in the request.");
        }

        // Get the requested book from the library using its ISBN as the key
        var book = library[isbn];

        // Check if the book exists in the library
        if (book is json) {
            // Remove the book from the library using map:remove
            var _ = map:remove(library, isbn);

            // Create an array to hold the updated book list
            json[] updatedBookList = [];

            // Iterate through the keys in the library map and retrieve the values
            foreach var key in library.keys() {
                var bookJson = library[key];
                if (bookJson is json) {
                    updatedBookList.push(bookJson);
                }
            }

            // Create a response message with the updated book list
            RemoveBookResponse response = { books: <Book[]>updatedBookList };
            return response;
        } else {
            // Book with the given ISBN doesn't exist, return an error
            
        }
    } else {
        // User is not a librarian, return an error
        return error("Only librarians are allowed to remove books.");
    }
}



 remote function ListAvailableBooks(ListAvailableBooksRequest value) returns ListAvailableBooksResponse|error {
    // Create an array to hold the available books
    json[] availableBooks = [];

    // Iterate through the keys in the library map and retrieve the corresponding values
    string[] isbnList = map:keys(library);
    foreach var isbn in isbnList {
        var bookJson = library[isbn];
        
        // Check if the "status" field exists and is a boolean
        if (bookJson is map<json>) {
            var statusValue = map:get(bookJson, "status");
            if (statusValue is boolean && statusValue == true) {
                availableBooks.push(bookJson);
            }
        }
    }

    // Create a response message with the available books
    ListAvailableBooksResponse response = { books: <Book[]>availableBooks };

    // Return the response
    return response;
}

   remote function LocateBook(LocateBookRequest value) returns LocateBookResponse|error {
    // Check if the requested ISBN exists in the library
    string? isbn = value.isbn;
    if (isbn != ()) {
        // Retrieve the book JSON using the ISBN
        var bookJson = library[isbn];

        // Check if the book exists and is available
        if (bookJson is map<json>) {
            var statusValue = map:get(bookJson, "status");
            if (statusValue is boolean && statusValue == true) {
                // Get the location of the book
                var locationValue = map:get(bookJson, "location");

                if (locationValue is string) {
                    // Create a response message with the book's location
                    LocateBookResponse response = { location: locationValue };

                    // Return the response
                    return response;
                } else {
                    // Location information is missing
                    return error("Location information is missing for the book");
                }
            } else {
                // Book is not available
                return error("Book is not available");
            }
        } else {
            // Book with the given ISBN doesn't exist
            return error("Book not found");
        }
    } else {
        // ISBN is missing in the request
        return error("ISBN is missing in the request");
    }
}
remote function BorrowBook(BorrowBookRequest value) returns BorrowBookResponse | error {
    // Access the user profile from the context
    User? user = getAuthenticatedUser();

    // Check if the user is a student
    if (user != () && user.profile == "STUDENT") {
        // Check if the book exists in the library
        var bookJson = library[value.isbn];

        if (bookJson is map<json>) {
            var statusValue = map:get(bookJson, "status");
            if (statusValue is boolean && statusValue == true) {
                // Check if the book is already borrowed by the same user
                var existingBorrowedBook = borrowedBooksMap[user.userId + "-" + value.isbn];
                
                if (existingBorrowedBook != ()) {
                    return error("You have already borrowed this book.");
                }

                // Create a new JSON object with the updated status
                json updatedBookJson = {
                    "title": bookJson["title"],
                    "author_1": bookJson["author_1"],
                    "location": bookJson["location"],
                    "isbn": bookJson["isbn"],
                    "status": false
                };

                // Update the book in the library with the new JSON object
                library[value.isbn] = updatedBookJson;

                // Record the book as borrowed by the user
                BorrowedBook borrowedBook = { userId: user.userId, isbn: value.isbn };
                borrowedBooksMap[user.userId + "-" + value.isbn] = borrowedBook;

                // Create a success response
                BorrowBookResponse response = { message: "Book borrowed successfully.", updated: false };

                // Return the response
                return response;
            }
        } else {
            return error("Book not found in the library.");
        }
    } else {
        return error("Only students are allowed to borrow books.");
    }
    
    return error("Borrowing process failed.");
}



function generateUniqueUserId() returns string {
    return ("");
}

function getAuthenticatedUser() returns User? {
    return ();
}

function LibraryError(string s) returns error {
    return error("");
}

function generateUniqueIsbn() returns string {
    return "";
}
}

function generateUniqueIsbn() returns string {
    return "";
}

function LibraryError(string s) returns error {
    return error("");
}

function generateUniqueUserId() returns string {
    return "";
}

function getAuthenticatedUser() returns User? {
    return ();
}
