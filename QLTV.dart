// Lớp trừu tượng Book định nghĩa các thuộc tính và phương thức cơ bản cho sách
abstract class Book {
  String _id; // Đóng gói: thuộc tính private
  String _title;
  String _author;
  bool _isAvailable;

  Book(this._id, this._title, this._author) : _isAvailable = true;

  // Getter và setter cho đóng gói
  String get id => _id;
  String get title => _title;
  String get author => _author;
  bool get isAvailable => _isAvailable;
  set isAvailable(bool value) => _isAvailable = value;

  // Phương thức trừu tượng, các lớp con phải triển khai
  String bookType();
}

// Lớp Textbook kế thừa từ Book
class Textbook extends Book {
  String _subject;

  Textbook(String id, String title, String author, this._subject)
    : super(id, title, author);

  String get subject => _subject;

  @override
  String bookType() => "Sách giáo khoa (Môn: $_subject)";
}

// Lớp ReferenceBook kế thừa từ Book
class ReferenceBook extends Book {
  String _category;

  ReferenceBook(String id, String title, String author, this._category)
    : super(id, title, author);

  String get category => _category;

  @override
  String bookType() => "Sách tham khảo (Danh mục: $_category)";
}

// Lớp Student
class Student {
  String _id;
  String _name;
  List<Book> _borrowedBooks;

  Student(this._id, this._name) : _borrowedBooks = [];

  String get id => _id;
  String get name => _name;
  List<Book> get borrowedBooks => _borrowedBooks;

  void borrowBook(Book book) {
    if (book.isAvailable) {
      _borrowedBooks.add(book);
      book.isAvailable = false;
      print("${_name} đã mượn '${book.title}'");
    } else {
      print("'${book.title}' hiện không có sẵn");
    }
  }

  void returnBook(Book book) {
    if (_borrowedBooks.contains(book)) {
      _borrowedBooks.remove(book);
      book.isAvailable = true;
      print("${_name} đã trả '${book.title}'");
    } else {
      print("${_name} không mượn '${book.title}'");
    }
  }
}

// Lớp Library quản lý sách và sinh viên
class Library {
  List<Book> _books;
  List<Student> _students;

  Library() : _books = [], _students = [];

  void addBook(Book book) {
    _books.add(book);
    print("Đã thêm '${book.title}' vào thư viện");
  }

  void addStudent(Student student) {
    _students.add(student);
    print("Đã thêm sinh viên ${student.name} vào thư viện");
  }

  void showAvailableBooks() {
    print("\nDanh sách sách có sẵn:");
    for (var book in _books) {
      if (book.isAvailable) {
        print("- ${book.title} (${book.bookType()})");
      }
    }
  }

  void showStudentBorrowedBooks(String studentId) {
    var student = _students.firstWhere(
      (s) => s.id == studentId,
      orElse: () => throw Exception("Không tìm thấy sinh viên"),
    );
    print("\nSách mà ${student.name} đang mượn:");
    if (student.borrowedBooks.isEmpty) {
      print("Chưa mượn sách nào");
    } else {
      for (var book in student.borrowedBooks) {
        print("- ${book.title} (${book.bookType()})");
      }
    }
  }
}

void main() {
  // Tạo thư viện
  var library = Library();

  // Tạo sách
  var textbook1 = Textbook("TB001", "Toán Cơ Bản", "Nguyễn Văn A", "Toán");
  var textbook2 = Textbook("TB002", "Vật Lý Cơ Bản", "Trần Thị B", "Vật Lý");
  var refBook1 = ReferenceBook(
    "RB001",
    "Bách Khoa Toàn Thư",
    "Nhiều tác giả",
    "Tổng hợp",
  );

  // Thêm sách vào thư viện
  library.addBook(textbook1);
  library.addBook(textbook2);
  library.addBook(refBook1);

  // Tạo sinh viên
  var student1 = Student("S001", "An");
  var student2 = Student("S002", "Bình");

  // Thêm sinh viên vào thư viện
  library.addStudent(student1);
  library.addStudent(student2);

  // Hiển thị sách có sẵn
  library.showAvailableBooks();

  // Sinh viên mượn sách
  student1.borrowBook(textbook1);
  student1.borrowBook(refBook1);
  student2.borrowBook(textbook2);

  // Hiển thị sách có sẵn sau khi mượn
  library.showAvailableBooks();

  // Hiển thị sách mà sinh viên đã mượn
  library.showStudentBorrowedBooks("S001");

  // Sinh viên trả sách
  student1.returnBook(textbook1);

  // Hiển thị sách có sẵn sau khi trả
  library.showAvailableBooks();

  // Hiển thị sách mà sinh viên đang mượn
  library.showStudentBorrowedBooks("S001");
}
