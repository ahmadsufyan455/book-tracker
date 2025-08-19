import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:librio/app_router.gr.dart';
import 'package:librio/core/theme/text_styles.dart';
import 'package:librio/data/local/entities/book.dart';
import 'package:librio/presentation/common_widgets/book_item.dart';
import 'package:librio/presentation/common_widgets/common_app_bar.dart';
import 'package:librio/presentation/pages/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: 'Librio',
        showBackButton: false,
        showHelpButton: true,
      ),
      body: StreamBuilder<List<Book>>(
        stream: context.read<HomeProvider>().booksStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final books = snapshot.data;
          if (books == null || books.isEmpty) {
            return Center(
              child: Text('No Books found', style: LibrioTextStyle.body),
            );
          }

          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        borderRadius: BorderRadius.circular(16),
                        onPressed: (context) {
                          showDeleteConfirmation(context, book.id!);
                        },
                        icon: Icons.delete,
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: BookItem(book: book),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushRoute(AddBookRoute()),
        child: const Icon(Icons.add),
      ),
    );
  }

  void showDeleteConfirmation(BuildContext context, int bookId) {
    final provider = context.read<HomeProvider>();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Book'),
          content: const Text('Are you sure want to delete this book?'),
          actions: [
            TextButton(
              onPressed: () => context.maybePop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                provider.deleteBook(bookId);
                context.maybePop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
