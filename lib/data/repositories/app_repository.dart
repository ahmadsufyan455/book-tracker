import 'package:librio/data/local/entities/book.dart';
import 'package:librio/data/local/entities/book_category.dart';

abstract interface class AppRepository {
  /// book operations
  Stream<List<Book>> getAllBooks();
  Future<void> addBook(Book book);
  Future<Book?> getBook(int id);
  Future<void> updateBook(Book book);
  Future<void> deleteBook(int id);

  /// category operations
  Future<void> addCategory(BookCategory category);
  Future<void> deleteCategory(int id);
  Stream<List<BookCategory>> getCategories();
  Future<void> updateCategory(BookCategory category);
}
