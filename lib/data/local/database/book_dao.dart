import 'package:floor/floor.dart';
import 'package:librio/data/local/entities/book.dart';

@dao
abstract class BookDao {
  @Query('SELECT * FROM Book')
  Stream<List<Book>> getAllBooks();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addBook(Book book);

  @Query('SELECT * FROM Book WHERE id = :id')
  Future<Book?> getBookById(int id);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateBook(Book book);

  @Query('DELETE FROM Book WHERE id = :id')
  Future<void> deleteBook(int id);
}
