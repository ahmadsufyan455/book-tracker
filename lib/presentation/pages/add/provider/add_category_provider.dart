import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:librio/data/local/entities/book_category.dart';
import 'package:librio/data/repositories/app_repository.dart';

@injectable
class AddCategoryProvider extends ChangeNotifier {
  final AppRepository _appRepository;

  AddCategoryProvider({required AppRepository appRepository})
    : _appRepository = appRepository;

  Stream<List<BookCategory>> get categories => _appRepository.getCategories();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> addCategory(BookCategory category) async {
    _errorMessage = null;
    try {
      await _appRepository.addCategory(category);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Something went wrong: $e';
    }
  }
}
