import 'package:librio/data/local/entities/book.dart';

class AddBookFormData {
  final String title;
  final String author;
  final String isbn;
  final String publisher;
  final String totalPages;
  final String description;
  final String currentPage;
  final String notes;

  const AddBookFormData({
    required this.title,
    required this.author,
    required this.isbn,
    required this.publisher,
    required this.totalPages,
    required this.description,
    required this.currentPage,
    required this.notes,
  });

  String get trimmedTitle => title.trim();
  String get trimmedAuthor => author.trim();
  String get trimmedIsbn => isbn.trim();
  String get trimmedPublisher => publisher.trim();
  String get trimmedTotalPages => totalPages.trim();
  String get trimmedDescription => description.trim();
  String get trimmedCurrentPage => currentPage.trim();
  String get trimmedNotes => notes.trim();

  int? get totalPagesAsInt {
    if (trimmedTotalPages.isEmpty) return null;
    return int.tryParse(trimmedTotalPages);
  }

  int? get currentPageAsInt {
    if (trimmedCurrentPage.isEmpty) return null;
    return int.tryParse(trimmedCurrentPage);
  }

  bool get hasValidRequiredFields =>
      trimmedTitle.isNotEmpty && trimmedAuthor.isNotEmpty;

  Book toBook({
    required int? id,
    required String? image,
    required String categories,
    required String status,
    int? currentPage,
  }) {
    return Book(
      id: id,
      title: trimmedTitle,
      image: image,
      auhtor: trimmedAuthor,
      isbn: trimmedIsbn.isNotEmpty ? trimmedIsbn : null,
      publisher: trimmedPublisher.isNotEmpty ? trimmedPublisher : null,
      categories: categories,
      totalPages: totalPagesAsInt ?? 0,
      status: status,
      currentPage: currentPage,
      notes: trimmedNotes.isNotEmpty ? trimmedNotes : null,
      description: trimmedDescription.isNotEmpty ? trimmedDescription : null,
    );
  }
}
