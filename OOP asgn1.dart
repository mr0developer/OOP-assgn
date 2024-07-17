import 'dart:io';
import 'dart:async';

// Step 1: Define an Interface
abstract class Borrowable {
  void borrowItem(String borrower);
  void returnItem();
}

// Step 2: Create a Base Class
class LibraryItem {
  String title;
  String author;

  LibraryItem(this.title, this.author);

  void displayInfo() {
    print('Title: $title, Author: $author');
  }
}

// Step 3, 4, and 6: Implement Inheritance, Override Methods, and Demonstrate Loop
class Book extends LibraryItem implements Borrowable {
  bool isBorrowed = false;
  String borrower = '';

  Book(String title, String author) : super(title, author);

  @override
  void borrowItem(String borrower) {
    if (!isBorrowed) {
      isBorrowed = true;
      this.borrower = borrower;
      print('$title has been borrowed by $borrower.');
    } else {
      print('$title is already borrowed by $this.borrower.');
    }
  }

  @override
  void returnItem() {
    if (isBorrowed) {
      isBorrowed = false;
      print('$title has been returned by $borrower.');
      borrower = '';
    } else {
      print('$title was not borrowed.');
    }
  }

  @override
  void displayInfo() {
    super.displayInfo();
    print('Borrowed: $isBorrowed');
  }

  void listChapters() {
    List<String> chapters = ['Chapter 1', 'Chapter 2', 'Chapter 3'];
    print('Chapters in $title:');
    for (String chapter in chapters) {
      print(chapter);
    }
  }
}

// Step 5: File Initialization
Future<Book> initializeBookFromFile(String filePath) async {
  try {
    final file = File(filePath);
    String contents = await file.readAsString();
    List<String> bookData = contents.split(',');

    if (bookData.length == 2) {
      return Book(bookData[0], bookData[1]);
    } else {
      throw Exception('Invalid file format');
    }
  } catch (e) {
    print('Error: $e');
    rethrow;
  }
}

Future<void> main() async {
  // Initialize a book from a file
  Book book = await initializeBookFromFile('book_data.txt');
  book.displayInfo();

  // Borrow and return the book
  book.borrowItem('John Doe');
  book.displayInfo();
  book.returnItem();
  book.displayInfo();

  // List chapters of the book
  book.listChapters();
}
