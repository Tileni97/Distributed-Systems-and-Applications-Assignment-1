import ballerina/io;


 LibraryServiceClient ep = check new ("http://localhost:9090");


public function main() returns error? {
   

    
        io:println("*****Library System Menu******");
        io:println("1. Add a new Book.");
        io:println("2. Create a new User.");
        io:println("3. Update book information.");
        io:println("4. Search book by ISBN.");
        io:println("5. Remove book by ISBN.");
        io:println("6. List books by author.");
        io:println("7. List books by location.");
        io:println("8. List available books.");
        io:println("9. Locate a book.");
        io:println("10. Borrow a book.");
        io:println("11. Exit.");
    string option = io:readln("Enter your choice (1-11): ");


        io:println("You entered: " + option);
        
        
        match option {
            "1" => {
                // Implement logic to add a new book
                AddBookRequest addBookRequest = {
                    user_profile: "ballerina",
                    book: {
                        isbn: "ballerina",
                        title: "ballerina",
                        author_1: "ballerina",
                        author_2: "ballerina",
                        location: "ballerina",
                        is_available: true
                    }
                };
                AddBookResponse addBookResponse = check ep->AddBook(addBookRequest);
                io:println(addBookResponse);
           }
            "2" => {
                // Implement logic to create a new user
                CreateUsersRequest createUsersRequest = {
                    users: [{user_id: "ballerina", user_type: "ballerina"}]
                };
                CreateUsersResponse createUsersResponse = check ep->CreateUsers(createUsersRequest);
                io:println(createUsersResponse);
            }

            "3" => {
                // Implement logic to update book information
                UpdateBookRequest updateBookRequest = {
                    book: {
                        isbn: "ballerina",
                        title: "ballerina",
                        author_1: "ballerina",
                        author_2: "ballerina",
                        location: "ballerina",
                        is_available: true
                    }
                };
                UpdateBookResponse updateBookResponse = check ep->UpdateBook(updateBookRequest);
                io:println(updateBookResponse);
            }
            "4" => {
    string _ = io:readln("Enter the ISBN to search for: ");
    // Implement logic to search for a book by ISBN
    // You can use the `searchIsbn` variable to perform the search
    // ...
}

           

            "5" => {
    string removeIsbn = io:readln("Enter the ISBN to remove: ");
    RemoveBookRequest removeBookRequest = {isbn: removeIsbn};
    RemoveBookResponse removeBookResponse = check ep->RemoveBook(removeBookRequest);
    io:println(removeBookResponse);
}

            "6" => {
    string _ = io:readln("Enter the author's name to list books: ");
    // Implement logic to list books by a specific author
    // You can use the `authorName` variable to filter and list books
    // ...
}

           "7" => {
    string _ = io:readln("Enter the location to list books: ");
    // Implement logic to list books by a specific location
    // You can use the `location` variable to filter and list books
    // ...
}


          "8" => {
    // Invoke the ListAvailableBooks remote function
    ListAvailableBooksRequest listAvailableBooksRequest = {user: {user_id: "ballerina", user_type: "ballerina"}};
    ListAvailableBooksResponse listAvailableBooksResponse = check ep->ListAvailableBooks(listAvailableBooksRequest);

    // Check if there are available books to list
    if (listAvailableBooksResponse.books.length() > 0) {
    io:println("Available Books:");
    foreach var book in listAvailableBooksResponse.books {
        io:println("ISBN: " + book.isbn);
        io:println("Title: " + book.title);
        io:println("Author: " + book.author_1);
        io:println("Location: " + book.location);
        io:println("----------------------------------");
    }
} else  {
        io:println("No available books found.");
    }
}



            "9" => {
    string locateIsbn = io:readln("Enter the ISBN of the book to locate: ");
    LocateBookRequest locateBookRequest = {isbn: locateIsbn};
    LocateBookResponse locateBookResponse = check ep->LocateBook(locateBookRequest);
    io:println(locateBookResponse);
}
"10" => {
    string borrowIsbn = io:readln("Enter the ISBN of the book to borrow: ");
    BorrowBookRequest borrowBookRequest = {user: {user_id: "ballerina", user_type: "ballerina"}, book_isbn: borrowIsbn};
    BorrowBookResponse borrowBookResponse = check ep->BorrowBook(borrowBookRequest);
    io:println(borrowBookResponse);
}
"11" => {
    io:println("Exiting...");

}


            _ => {
                io:println("Invalid choice. Please enter a valid option (1-9).");
            }
        }
    
    return ();
}
