import 'dart:async';

import 'package:floor/floor.dart';
import 'package:librio/data/local/database/book_category_dao.dart';
import 'package:librio/data/local/database/book_dao.dart';
import 'package:librio/data/local/entities/book.dart';
import 'package:librio/data/local/entities/book_category.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart'; // generated code will be here

@Database(version: 1, entities: [Book, BookCategory])
abstract class AppDatabase extends FloorDatabase {
  BookDao get bookDao;
  BookCategoryDao get bookCategoryDao;

  static Future<AppDatabase> init() async {
    return await $FloorAppDatabase.databaseBuilder('book_database.db').build();
  }
}
