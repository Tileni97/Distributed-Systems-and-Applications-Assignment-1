import ballerina/grpc;
import ballerina/protobuf;

public const string LIBRARY_DESC = "0A0D6C6962726172792E70726F746F22A5010A04426F6F6B12120A046973626E18012001280952046973626E12140A057469746C6518022001280952057469746C6512190A08617574686F725F311803200128095207617574686F723112190A08617574686F725F321804200128095207617574686F7232121A0A086C6F636174696F6E18052001280952086C6F636174696F6E12210A0C69735F617661696C61626C65180620012808520B6973417661696C61626C65223C0A045573657212170A07757365725F69641801200128095206757365724964121B0A09757365725F7479706518022001280952087573657254797065224E0A0E416464426F6F6B5265717565737412210A0C757365725F70726F66696C65180120012809520B7573657250726F66696C6512190A04626F6F6B18022001280B32052E426F6F6B5204626F6F6B22250A0F416464426F6F6B526573706F6E736512120A046973626E18012001280952046973626E22310A12437265617465557365727352657175657374121B0A05757365727318012003280B32052E557365725205757365727322320A134372656174655573657273526573706F6E7365121B0A05757365727318012003280B32052E5573657252057573657273222E0A11557064617465426F6F6B5265717565737412190A04626F6F6B18012001280B32052E426F6F6B5204626F6F6B223E0A12557064617465426F6F6B526573706F6E736512280A0C757064617465645F626F6F6B18012001280B32052E426F6F6B520B75706461746564426F6F6B22270A1152656D6F7665426F6F6B5265717565737412120A046973626E18012001280952046973626E22310A1252656D6F7665426F6F6B526573706F6E7365121B0A05626F6F6B7318012003280B32052E426F6F6B5205626F6F6B7322360A194C697374417661696C61626C65426F6F6B735265717565737412190A047573657218012001280B32052E5573657252047573657222390A1A4C697374417661696C61626C65426F6F6B73526573706F6E7365121B0A05626F6F6B7318012003280B32052E426F6F6B5205626F6F6B7322270A114C6F63617465426F6F6B5265717565737412120A046973626E18012001280952046973626E22300A124C6F63617465426F6F6B526573706F6E7365121A0A086C6F636174696F6E18012001280952086C6F636174696F6E224B0A11426F72726F77426F6F6B5265717565737412190A047573657218012001280B32052E55736572520475736572121B0A09626F6F6B5F6973626E1802200128095208626F6F6B4973626E222E0A12426F72726F77426F6F6B526573706F6E736512180A077375636365737318012001280852077375636365737332A3030A0E4C69627261727953657276696365122C0A07416464426F6F6B120F2E416464426F6F6B526571756573741A102E416464426F6F6B526573706F6E736512380A0B437265617465557365727312132E4372656174655573657273526571756573741A142E4372656174655573657273526573706F6E736512350A0A557064617465426F6F6B12122E557064617465426F6F6B526571756573741A132E557064617465426F6F6B526573706F6E736512350A0A52656D6F7665426F6F6B12122E52656D6F7665426F6F6B526571756573741A132E52656D6F7665426F6F6B526573706F6E7365124D0A124C697374417661696C61626C65426F6F6B73121A2E4C697374417661696C61626C65426F6F6B73526571756573741A1B2E4C697374417661696C61626C65426F6F6B73526573706F6E736512350A0A4C6F63617465426F6F6B12122E4C6F63617465426F6F6B526571756573741A132E4C6F63617465426F6F6B526573706F6E736512350A0A426F72726F77426F6F6B12122E426F72726F77426F6F6B526571756573741A132E426F72726F77426F6F6B526573706F6E7365620670726F746F33";

public isolated client class LibraryServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, LIBRARY_DESC);
    }

    isolated remote function AddBook(AddBookRequest|ContextAddBookRequest req) returns AddBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddBookRequest message;
        if req is ContextAddBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/AddBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <AddBookResponse>result;
    }

    isolated remote function AddBookContext(AddBookRequest|ContextAddBookRequest req) returns ContextAddBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddBookRequest message;
        if req is ContextAddBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/AddBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <AddBookResponse>result, headers: respHeaders};
    }

    isolated remote function CreateUsers(CreateUsersRequest|ContextCreateUsersRequest req) returns CreateUsersResponse|grpc:Error {
        map<string|string[]> headers = {};
        CreateUsersRequest message;
        if req is ContextCreateUsersRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/CreateUsers", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CreateUsersResponse>result;
    }

    isolated remote function CreateUsersContext(CreateUsersRequest|ContextCreateUsersRequest req) returns ContextCreateUsersResponse|grpc:Error {
        map<string|string[]> headers = {};
        CreateUsersRequest message;
        if req is ContextCreateUsersRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/CreateUsers", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CreateUsersResponse>result, headers: respHeaders};
    }

    isolated remote function UpdateBook(UpdateBookRequest|ContextUpdateBookRequest req) returns UpdateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateBookRequest message;
        if req is ContextUpdateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/UpdateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <UpdateBookResponse>result;
    }

    isolated remote function UpdateBookContext(UpdateBookRequest|ContextUpdateBookRequest req) returns ContextUpdateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateBookRequest message;
        if req is ContextUpdateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/UpdateBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <UpdateBookResponse>result, headers: respHeaders};
    }

    isolated remote function RemoveBook(RemoveBookRequest|ContextRemoveBookRequest req) returns RemoveBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveBookRequest message;
        if req is ContextRemoveBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/RemoveBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <RemoveBookResponse>result;
    }

    isolated remote function RemoveBookContext(RemoveBookRequest|ContextRemoveBookRequest req) returns ContextRemoveBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveBookRequest message;
        if req is ContextRemoveBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/RemoveBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <RemoveBookResponse>result, headers: respHeaders};
    }

    isolated remote function ListAvailableBooks(ListAvailableBooksRequest|ContextListAvailableBooksRequest req) returns ListAvailableBooksResponse|grpc:Error {
        map<string|string[]> headers = {};
        ListAvailableBooksRequest message;
        if req is ContextListAvailableBooksRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/ListAvailableBooks", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ListAvailableBooksResponse>result;
    }

    isolated remote function ListAvailableBooksContext(ListAvailableBooksRequest|ContextListAvailableBooksRequest req) returns ContextListAvailableBooksResponse|grpc:Error {
        map<string|string[]> headers = {};
        ListAvailableBooksRequest message;
        if req is ContextListAvailableBooksRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/ListAvailableBooks", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ListAvailableBooksResponse>result, headers: respHeaders};
    }

    isolated remote function LocateBook(LocateBookRequest|ContextLocateBookRequest req) returns LocateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        LocateBookRequest message;
        if req is ContextLocateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/LocateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <LocateBookResponse>result;
    }

    isolated remote function LocateBookContext(LocateBookRequest|ContextLocateBookRequest req) returns ContextLocateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        LocateBookRequest message;
        if req is ContextLocateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/LocateBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <LocateBookResponse>result, headers: respHeaders};
    }

    isolated remote function BorrowBook(BorrowBookRequest|ContextBorrowBookRequest req) returns BorrowBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        BorrowBookRequest message;
        if req is ContextBorrowBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/BorrowBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <BorrowBookResponse>result;
    }

    isolated remote function BorrowBookContext(BorrowBookRequest|ContextBorrowBookRequest req) returns ContextBorrowBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        BorrowBookRequest message;
        if req is ContextBorrowBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/BorrowBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <BorrowBookResponse>result, headers: respHeaders};
    }
}

public type ContextRemoveBookRequest record {|
    RemoveBookRequest content;
    map<string|string[]> headers;
|};

public type ContextBorrowBookResponse record {|
    BorrowBookResponse content;
    map<string|string[]> headers;
|};

public type ContextListAvailableBooksRequest record {|
    ListAvailableBooksRequest content;
    map<string|string[]> headers;
|};

public type ContextAddBookRequest record {|
    AddBookRequest content;
    map<string|string[]> headers;
|};

public type ContextAddBookResponse record {|
    AddBookResponse content;
    map<string|string[]> headers;
|};

public type ContextRemoveBookResponse record {|
    RemoveBookResponse content;
    map<string|string[]> headers;
|};

public type ContextCreateUsersRequest record {|
    CreateUsersRequest content;
    map<string|string[]> headers;
|};

public type ContextLocateBookRequest record {|
    LocateBookRequest content;
    map<string|string[]> headers;
|};

public type ContextLocateBookResponse record {|
    LocateBookResponse content;
    map<string|string[]> headers;
|};

public type ContextListAvailableBooksResponse record {|
    ListAvailableBooksResponse content;
    map<string|string[]> headers;
|};

public type ContextUpdateBookRequest record {|
    UpdateBookRequest content;
    map<string|string[]> headers;
|};

public type ContextBorrowBookRequest record {|
    BorrowBookRequest content;
    map<string|string[]> headers;
|};

public type ContextUpdateBookResponse record {|
    UpdateBookResponse content;
    map<string|string[]> headers;
|};

public type ContextCreateUsersResponse record {|
    CreateUsersResponse content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type User record {|
    string user_id = "";
    string user_type = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type RemoveBookRequest record {|
    string isbn = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type BorrowBookResponse record {|
    boolean success = false;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type ListAvailableBooksRequest record {|
    User user = {};
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type AddBookRequest record {|
    string user_profile = "";
    Book book = {};
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type AddBookResponse record {|
    string isbn = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type RemoveBookResponse record {|
    Book[] books = [];
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type CreateUsersRequest record {|
    User[] users = [];
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type LocateBookRequest record {|
    string isbn = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type LocateBookResponse record {|
    string location = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type ListAvailableBooksResponse record {|
    Book[] books = [];
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type Book record {|
    string isbn = "";
    string title = "";
    string author_1 = "";
    string author_2 = "";
    string location = "";
    boolean is_available = false;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type UpdateBookRequest record {|
    Book book = {};
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type BorrowBookRequest record {|
    User user = {};
    string book_isbn = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type UpdateBookResponse record {|
    Book updated_book = {};
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type CreateUsersResponse record {|
    User[] users = [];
|};

