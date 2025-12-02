import '../Models/book.dart';
import 'database_helper.dart';
import 'user_service.dart';

class BookService {
  Future<void> insertBook(Book book) async {
    final db = await DatabaseHelper.instance.database;
    // Try to associate with current user if available
    String? userEmail;
    try {
      final currentUser = await UserService().getCurrentUser();
      userEmail = currentUser?.email;
    } catch (_) {}
    await db.transaction((txn) async {
      await txn.rawInsert(
        "INSERT INTO book(name, price, image, userEmail) VALUES(?, ?, ?, ?)",
        [book.name, book.price, book.image, userEmail],
      );
    });
  }

  Future<void> insertBookForUser(Book book, String userEmail) async {
    final db = await DatabaseHelper.instance.database;
    await db.transaction((txn) async {
      await txn.rawInsert(
        "INSERT INTO book(name, price, image, userEmail) VALUES(?, ?, ?, ?)",
        [book.name, book.price, book.image, userEmail],
      );
    });
  }

  Future<List<Book>> fetchBasketBooks() async {
    final db = await DatabaseHelper.instance.database;
    final List<Book> books = [];
    await db.transaction((txn) async {
      final List<Map<String, Object?>> list = await txn.rawQuery("SELECT * FROM book");
      for (final element in list) {
        books.add(
          Book(
            element["name"] as String,
            element["price"] as int,
            (element["image"] ?? '').toString(),
          ),
        );
      }
    });
    return books;
  }

  Future<List<Book>> fetchBasketBooksForUser(String userEmail) async {
    final db = await DatabaseHelper.instance.database;
    final List<Book> books = [];
    await db.transaction((txn) async {
      final List<Map<String, Object?>> list = await txn.rawQuery(
        "SELECT * FROM book WHERE userEmail = ?",
        [userEmail],
      );
      for (final element in list) {
        books.add(
          Book(
            element["name"] as String,
            element["price"] as int,
            (element["image"] ?? '').toString(),
          ),
        );
      }
    });
    return books;
  }

  Future<int> deleteBookByName(String name) async {
    final db = await DatabaseHelper.instance.database;
    return db.delete('book', where: 'name = ?', whereArgs: [name]);
  }

  Future<int> clearBasket() async {
    final db = await DatabaseHelper.instance.database;
    return db.delete('book');
  }

  Future<int> updateBook(Book book) async {
    final db = await DatabaseHelper.instance.database;
    // Update price and image for the given book name
    return db.update(
      'book',
      {
        'price': book.price,
        'image': book.image,
      },
      where: 'name = ?',
      whereArgs: [book.name],
    );
  }
}
