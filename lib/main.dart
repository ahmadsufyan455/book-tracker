import 'package:flutter/material.dart';
import 'package:librio/app_router.dart';
import 'package:librio/core/di/injection.dart';
import 'package:librio/core/theme/themes.dart';
import 'package:librio/presentation/pages/add/provider/add_book_form_provider.dart';
import 'package:librio/presentation/pages/add/provider/add_book_provider.dart';
import 'package:librio/presentation/pages/add/provider/add_category_provider.dart';
import 'package:librio/presentation/pages/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

final appRouter = AppRouter();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<AddBookProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<AddBookFormProvider>()),
        Provider(create: (_) => getIt<HomeProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<AddCategoryProvider>()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Librio',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter.config(),
    );
  }
}
