import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:librio/data/local/entities/book.dart';
import 'package:librio/data/repositories/app_repository.dart';

@injectable
class AddBookProvider extends ChangeNotifier {
  final AppRepository _appRepository;

  AddBookProvider({required AppRepository appRepository})
    : _appRepository = appRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> addBook(Book book) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await _appRepository.addBook(book);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to add book';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateBook(Book book) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    try {
      await _appRepository.updateBook(book);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update book';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
