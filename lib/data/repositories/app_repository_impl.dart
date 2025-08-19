import 'package:injectable/injectable.dart';
import 'package:librio/data/local/database/app_database.dart';
import 'package:librio/data/local/entities/book.dart';
import 'package:librio/data/local/entities/book_category.dart';
import 'package:librio/data/repositories/app_repository.dart';

@LazySingleton(as: AppRepository)
class AppRepositoryImpl implements AppRepository {
  final AppDatabase _appDatabase;

  AppRepositoryImpl({required AppDatabase appDatabase})
    : _appDatabase = appDatabase;

  @override
  Future<void> addBook(Book book) async {
    await _appDatabase.bookDao.addBook(book);
  }

  @override
  Future<void> deleteBook(int id) async {
    await _appDatabase.bookDao.deleteBook(id);
  }

  @override
  Stream<List<Book>> getAllBooks() {
    return _appDatabase.bookDao.getAllBooks();
  }

  @override
  Future<Book?> getBook(int id) async {
    return await _appDatabase.bookDao.getBookById(id);
  }

  @override
  Future<void> updateBook(Book book) async {
    await _appDatabase.bookDao.updateBook(book);
  }

  @override
  Future<void> addCategory(BookCategory category) async {
    await _appDatabase.bookCategoryDao.addBookCategory(category);
  }

  @override
  Future<void> deleteCategory(int id) async {
    await _appDatabase.bookCategoryDao.deleteBookCategory(id);
  }

  @override
  Stream<List<BookCategory>> getCategories() {
    return _appDatabase.bookCategoryDao.getCategories();
  }

  @override
  Future<void> updateCategory(BookCategory category) async {
    await _appDatabase.bookCategoryDao.updateBookCategory(category);
  }
}
