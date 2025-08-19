// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BookDao? _bookDaoInstance;

  BookCategoryDao? _bookCategoryDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Book` (`id` INTEGER, `image` TEXT, `title` TEXT NOT NULL, `author` TEXT NOT NULL, `description` TEXT, `isbn` TEXT, `publisher` TEXT, `categories` TEXT, `total_pages` INTEGER NOT NULL, `status` TEXT NOT NULL, `current_page` INTEGER, `notes` TEXT, `created_at` TEXT NOT NULL, `updated_at` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `category` (`id` INTEGER, `name` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BookDao get bookDao {
    return _bookDaoInstance ??= _$BookDao(database, changeListener);
  }

  @override
  BookCategoryDao get bookCategoryDao {
    return _bookCategoryDaoInstance ??=
        _$BookCategoryDao(database, changeListener);
  }
}

class _$BookDao extends BookDao {
  _$BookDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _bookInsertionAdapter = InsertionAdapter(
            database,
            'Book',
            (Book item) => <String, Object?>{
                  'id': item.id,
                  'image': item.image,
                  'title': item.title,
                  'author': item.auhtor,
                  'description': item.description,
                  'isbn': item.isbn,
                  'publisher': item.publisher,
                  'categories': item.categories,
                  'total_pages': item.totalPages,
                  'status': item.status,
                  'current_page': item.currentPage,
                  'notes': item.notes,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                },
            changeListener),
        _bookUpdateAdapter = UpdateAdapter(
            database,
            'Book',
            ['id'],
            (Book item) => <String, Object?>{
                  'id': item.id,
                  'image': item.image,
                  'title': item.title,
                  'author': item.auhtor,
                  'description': item.description,
                  'isbn': item.isbn,
                  'publisher': item.publisher,
                  'categories': item.categories,
                  'total_pages': item.totalPages,
                  'status': item.status,
                  'current_page': item.currentPage,
                  'notes': item.notes,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Book> _bookInsertionAdapter;

  final UpdateAdapter<Book> _bookUpdateAdapter;

  @override
  Stream<List<Book>> getAllBooks() {
    return _queryAdapter.queryListStream('SELECT * FROM Book',
        mapper: (Map<String, Object?> row) => Book(
            id: row['id'] as int?,
            image: row['image'] as String?,
            auhtor: row['author'] as String,
            title: row['title'] as String,
            description: row['description'] as String?,
            isbn: row['isbn'] as String?,
            publisher: row['publisher'] as String?,
            categories: row['categories'] as String?,
            totalPages: row['total_pages'] as int,
            status: row['status'] as String?,
            currentPage: row['current_page'] as int?,
            notes: row['notes'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        queryableName: 'Book',
        isView: false);
  }

  @override
  Future<Book?> getBookById(int id) async {
    return _queryAdapter.query('SELECT * FROM Book WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Book(
            id: row['id'] as int?,
            image: row['image'] as String?,
            auhtor: row['author'] as String,
            title: row['title'] as String,
            description: row['description'] as String?,
            isbn: row['isbn'] as String?,
            publisher: row['publisher'] as String?,
            categories: row['categories'] as String?,
            totalPages: row['total_pages'] as int,
            status: row['status'] as String?,
            currentPage: row['current_page'] as int?,
            notes: row['notes'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteBook(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Book WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> addBook(Book book) async {
    await _bookInsertionAdapter.insert(book, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateBook(Book book) async {
    await _bookUpdateAdapter.update(book, OnConflictStrategy.replace);
  }
}

class _$BookCategoryDao extends BookCategoryDao {
  _$BookCategoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _bookCategoryInsertionAdapter = InsertionAdapter(
            database,
            'category',
            (BookCategory item) =>
                <String, Object?>{'id': item.id, 'name': item.name},
            changeListener),
        _bookCategoryUpdateAdapter = UpdateAdapter(
            database,
            'category',
            ['id'],
            (BookCategory item) =>
                <String, Object?>{'id': item.id, 'name': item.name},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BookCategory> _bookCategoryInsertionAdapter;

  final UpdateAdapter<BookCategory> _bookCategoryUpdateAdapter;

  @override
  Stream<List<BookCategory>> getCategories() {
    return _queryAdapter.queryListStream('SELECT * FROM category',
        mapper: (Map<String, Object?> row) =>
            BookCategory(id: row['id'] as int?, name: row['name'] as String),
        queryableName: 'category',
        isView: false);
  }

  @override
  Future<BookCategory?> getBookCategoryById(int id) async {
    return _queryAdapter.query('SELECT * FROM category WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            BookCategory(id: row['id'] as int?, name: row['name'] as String),
        arguments: [id]);
  }

  @override
  Future<void> deleteBookCategory(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM category WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> addBookCategory(BookCategory bookCategory) async {
    await _bookCategoryInsertionAdapter.insert(
        bookCategory, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateBookCategory(BookCategory bookCategory) async {
    await _bookCategoryUpdateAdapter.update(
        bookCategory, OnConflictStrategy.replace);
  }
}
