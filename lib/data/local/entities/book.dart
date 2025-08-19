import 'package:floor/floor.dart';
import 'package:librio/core/enum/reading_status_enum.dart';

@entity
class Book {
  @primaryKey
  final int? id;

  @ColumnInfo(name: 'image')
  final String? image;

  @ColumnInfo(name: 'title')
  final String title;

  @ColumnInfo(name: 'author')
  final String auhtor;

  @ColumnInfo(name: 'description')
  final String? description;

  @ColumnInfo(name: 'isbn')
  final String? isbn;

  @ColumnInfo(name: 'publisher')
  final String? publisher;

  @ColumnInfo(name: 'categories')
  final String? categories; // Comma-separated string of selected categories

  @ColumnInfo(name: 'total_pages')
  final int totalPages;

  @ColumnInfo(name: 'status')
  final String status; // Store as string, convert to enum when needed

  @ColumnInfo(name: 'current_page')
  final int? currentPage;

  @ColumnInfo(name: 'notes')
  final String? notes;

  @ColumnInfo(name: 'created_at')
  final String createdAt;

  @ColumnInfo(name: 'updated_at')
  final String updatedAt;

  Book({
    this.id,
    this.image,
    required this.auhtor,
    required this.title,
    this.description,
    this.isbn,
    this.publisher,
    this.categories,
    required this.totalPages,
    String? status,
    this.currentPage,
    this.notes,
    String? createdAt,
    String? updatedAt,
  }) : status = status ?? ReadingStatus.toRead.displayName,
       createdAt = createdAt ?? DateTime.now().toIso8601String(),
       updatedAt = updatedAt ?? DateTime.now().toIso8601String();

  // Helper method to get categories as List<String>
  List<String> get categoriesList {
    if (categories == null || categories!.isEmpty) return [];
    try {
      return categories!.split(',').map((e) => e.trim()).toList();
    } catch (e) {
      return [];
    }
  }

  // Helper method to get status as enum
  ReadingStatus get statusEnum => ReadingStatus.fromString(status);

  // Helper method to get created date as DateTime
  DateTime get createdAtDateTime => DateTime.parse(createdAt);

  // Helper method to get updated date as DateTime
  DateTime get updatedAtDateTime => DateTime.parse(updatedAt);
}
