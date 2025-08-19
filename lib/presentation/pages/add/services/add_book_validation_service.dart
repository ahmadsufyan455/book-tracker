import 'package:librio/core/enum/reading_status_enum.dart';

class AddBookValidationService {
  static String? validateRequiredFields({
    required String title,
    required String author,
  }) {
    if (title.isEmpty || author.isEmpty) {
      return 'Title and Author are required';
    }
    return null;
  }

  static String? validateTotalPages(String pages) {
    if (pages.isNotEmpty) {
      final totalPages = int.tryParse(pages);
      if (totalPages == null || totalPages <= 0) {
        return 'Please enter a valid number of pages';
      }
    }
    return null;
  }

  static String? validateCurrentPage({
    required String currentPageText,
    required ReadingStatus status,
    int? totalPages,
  }) {
    if (status == ReadingStatus.reading && currentPageText.isNotEmpty) {
      final currentPage = int.tryParse(currentPageText);
      if (currentPage == null || currentPage <= 0) {
        return 'Please enter a valid current page number';
      }
      if (totalPages != null && currentPage > totalPages) {
        return 'Current page cannot be greater than total pages';
      }
    }
    return null;
  }
}
