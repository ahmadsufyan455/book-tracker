// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:librio/data/local/entities/book.dart' as _i9;
import 'package:librio/presentation/pages/add/add_book_page.dart' as _i1;
import 'package:librio/presentation/pages/home/home_page.dart' as _i2;
import 'package:librio/presentation/pages/library/library_page.dart' as _i3;
import 'package:librio/presentation/pages/main_navigation/main_navigation_page.dart'
    as _i4;
import 'package:librio/presentation/pages/settings/settings_page.dart' as _i5;
import 'package:librio/presentation/pages/stats/stats_page.dart' as _i6;

/// generated route for
/// [_i1.AddBookPage]
class AddBookRoute extends _i7.PageRouteInfo<AddBookRouteArgs> {
  AddBookRoute({
    _i8.Key? key,
    _i9.Book? book,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          AddBookRoute.name,
          args: AddBookRouteArgs(
            key: key,
            book: book,
          ),
          initialChildren: children,
        );

  static const String name = 'AddBookRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<AddBookRouteArgs>(orElse: () => const AddBookRouteArgs());
      return _i1.AddBookPage(
        key: args.key,
        book: args.book,
      );
    },
  );
}

class AddBookRouteArgs {
  const AddBookRouteArgs({
    this.key,
    this.book,
  });

  final _i8.Key? key;

  final _i9.Book? book;

  @override
  String toString() {
    return 'AddBookRouteArgs{key: $key, book: $book}';
  }
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}

/// generated route for
/// [_i3.LibraryPage]
class LibraryRoute extends _i7.PageRouteInfo<void> {
  const LibraryRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LibraryRoute.name,
          initialChildren: children,
        );

  static const String name = 'LibraryRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.LibraryPage();
    },
  );
}

/// generated route for
/// [_i4.MainNavigationPage]
class MainNavigationRoute extends _i7.PageRouteInfo<void> {
  const MainNavigationRoute({List<_i7.PageRouteInfo>? children})
      : super(
          MainNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainNavigationRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.MainNavigationPage();
    },
  );
}

/// generated route for
/// [_i5.SettingsPage]
class SettingsRoute extends _i7.PageRouteInfo<void> {
  const SettingsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.SettingsPage();
    },
  );
}

/// generated route for
/// [_i6.StatsPage]
class StatsRoute extends _i7.PageRouteInfo<void> {
  const StatsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          StatsRoute.name,
          initialChildren: children,
        );

  static const String name = 'StatsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.StatsPage();
    },
  );
}
