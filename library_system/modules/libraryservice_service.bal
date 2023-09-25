import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: LIBRARY_DESC}
service "LibraryService" on ep {

    remote function AddBook(AddBookRequest value) returns AddBookResponse|error {
    }
    remote function CreateUsers(CreateUsersRequest value) returns CreateUsersResponse|error {
    }
    remote function UpdateBook(UpdateBookRequest value) returns UpdateBookResponse|error {
    }
    remote function RemoveBook(RemoveBookRequest value) returns RemoveBookResponse|error {
    }
    remote function ListAvailableBooks(ListAvailableBooksRequest value) returns ListAvailableBooksResponse|error {
    }
    remote function LocateBook(LocateBookRequest value) returns LocateBookResponse|error {
    }
    remote function BorrowBook(BorrowBookRequest value) returns BorrowBookResponse|error {
    }
}

