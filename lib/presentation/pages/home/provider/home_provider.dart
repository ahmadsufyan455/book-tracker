import 'package:injectable/injectable.dart';
import 'package:librio/data/local/entities/book.dart';
import 'package:librio/data/repositories/app_repository.dart';

@injectable
class HomeProvider {
  final AppRepository _appRepository;

  HomeProvider({required AppRepository appRepository})
    : _appRepository = appRepository;

  Stream<List<Book>> get booksStream => _appRepository.getAllBooks();

  Future<void> deleteBook(int id) async {
    await _appRepository.deleteBook(id);
  }
}
