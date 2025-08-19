import 'package:injectable/injectable.dart';
import 'package:librio/data/local/database/app_database.dart';

@module
abstract class AppModule {
  @lazySingleton
  @preResolve
  Future<AppDatabase> database() => AppDatabase.init();
}
