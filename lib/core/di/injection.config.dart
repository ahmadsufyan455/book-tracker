// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:librio/core/di/app_module.dart' as _i443;
import 'package:librio/data/local/database/app_database.dart' as _i858;
import 'package:librio/data/repositories/app_repository.dart' as _i365;
import 'package:librio/data/repositories/app_repository_impl.dart' as _i879;
import 'package:librio/presentation/pages/add/provider/add_book_form_provider.dart'
    as _i732;
import 'package:librio/presentation/pages/add/provider/add_book_provider.dart'
    as _i138;
import 'package:librio/presentation/pages/add/provider/add_category_provider.dart'
    as _i726;
import 'package:librio/presentation/pages/home/provider/home_provider.dart'
    as _i799;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i732.AddBookFormProvider>(() => _i732.AddBookFormProvider());
    await gh.lazySingletonAsync<_i858.AppDatabase>(
      () => appModule.database(),
      preResolve: true,
    );
    gh.lazySingleton<_i365.AppRepository>(
        () => _i879.AppRepositoryImpl(appDatabase: gh<_i858.AppDatabase>()));
    gh.factory<_i799.HomeProvider>(
        () => _i799.HomeProvider(appRepository: gh<_i365.AppRepository>()));
    gh.factory<_i138.AddBookProvider>(
        () => _i138.AddBookProvider(appRepository: gh<_i365.AppRepository>()));
    gh.factory<_i726.AddCategoryProvider>(() =>
        _i726.AddCategoryProvider(appRepository: gh<_i365.AppRepository>()));
    return this;
  }
}

class _$AppModule extends _i443.AppModule {}
