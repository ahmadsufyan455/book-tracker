import 'package:floor/floor.dart';
import 'package:librio/data/local/entities/book_category.dart';

@dao
abstract class BookCategoryDao {
  @Query('SELECT * FROM category')
  Stream<List<BookCategory>> getCategories();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addBookCategory(BookCategory bookCategory);

  @Query('SELECT * FROM category WHERE id = :id')
  Future<BookCategory?> getBookCategoryById(int id);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateBookCategory(BookCategory bookCategory);

  @Query('DELETE FROM category WHERE id = :id')
  Future<void> deleteBookCategory(int id);
}
