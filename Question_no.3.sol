// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Library {
    struct Book {
        uint ID;
        string name;
        string author;
        bool isAvailable;
    }

    mapping (uint => Book) public books;
    mapping (address => uint[]) public borrowed_books;
    uint public nextID;
    modifier onlyValidBookId(uint _id) {
        require(books[_id].ID != 0, "Book ID is not valid");
        _;
    }
    constructor() {
        nextID = 1;
    }

    function addBook(string memory _name, string memory _author) public {
        Book storage newBook = books[nextID];
        newBook.ID = nextID;
        newBook.name = _name;
        newBook.author = _author;
        newBook.isAvailable = true;
        nextID++;
    }

    // function borrowBook(uint _id) public onlyValidBookId(_id) {
    //     Book storage book = books[_id];
    //     require(book.isAvailable, "Book is not available");
    //     book.isAvailable = false;
    //     borrowed_books[msg.sender].push(_id);
    // }
    function borrowBook(uint _id) public onlyValidBookId(_id) {
        Book storage book = books[_id];
        require(book.isAvailable, "Book is not available");
        book.isAvailable = false;
        borrowed_books[msg.sender].push(_id);
    }

    function getBookDetails(uint _id) public view onlyValidBookId(_id) returns (string memory, string memory, bool) {
        Book storage book = books[_id];
        return (book.name, book.author, book.isAvailable);
    }
    function returnBook(uint _id) public onlyValidBookId(_id) {
        Book storage book = books[_id];
        require(!book.isAvailable, "Book is already available");
        require(isBorrowedBy(msg.sender, _id), "You did not borrow this book");
        book.isAvailable = true;
        removeBookFromBorrowedList(msg.sender, _id);
    }
    function isBorrowedBy(address _address, uint _id) internal view returns (bool) {
        uint[] storage borrowedBookIds = borrowed_books[_address];
        for (uint i = 0; i < borrowedBookIds.length; i++) {
            if (borrowedBookIds[i] == _id) {
                return true;
            }
        }
        return false;
    }

    function removeBookFromBorrowedList(address _address, uint _id) internal {
        uint[] storage borrowedBookIds = borrowed_books[_address];
        for (uint i = 0; i < borrowedBookIds.length; i++) {
            if (borrowedBookIds[i] == _id) {
                delete borrowedBookIds[i];
                break;
            }
        }
    }
    }

