import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:librio/core/enum/reading_status_enum.dart';
import 'package:librio/core/ext/ext_context.dart';
import 'package:librio/core/theme/text_styles.dart';
import 'package:librio/data/local/entities/book.dart';
import 'package:librio/presentation/common_widgets/book_item.dart';
import 'package:librio/presentation/common_widgets/common_app_bar.dart';
import 'package:librio/presentation/common_widgets/search_widget.dart';
import 'package:librio/presentation/pages/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

@RoutePage()
class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  String _searchQuery = '';
  String? _selectedCategory;
  String? _selectedStatus;
  bool _isGridView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Library',
        showBackButton: false,
        showHelpButton: true,
        additionalActions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
            icon: Icon(
              _isGridView ? Icons.view_list : Icons.grid_view,
              color: context.theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filters
          _buildSearchAndFilters(),

          // Books List/Grid
          Expanded(
            child: StreamBuilder<List<Book>>(
              stream: context.read<HomeProvider>().booksStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final allBooks = snapshot.data ?? [];
                final filteredBooks = _filterBooks(allBooks);

                if (filteredBooks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.library_books_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          allBooks.isEmpty ? 'No books yet' : 'No books found',
                          style: LibrioTextStyle.body?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        if (allBooks.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Try adjusting your search or filters',
                            style: LibrioTextStyle.smallBody?.copyWith(
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }

                return _isGridView
                    ? _buildGridView(filteredBooks)
                    : _buildListView(filteredBooks);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Search Bar
          SearchWidget(
            searchQuery: _searchQuery,
            onSearchChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            onClear: () {
              setState(() {
                _searchQuery = '';
              });
            },
            hintText: 'Search books...',
          ),
        ],
      ),
    );
  }

  Widget _buildListView(List<Book> books) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  borderRadius: BorderRadius.circular(16),
                  onPressed: (context) {
                    _showDeleteConfirmation(context, book.id!);
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
  }

  Widget _buildGridView(List<Book> books) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return _buildGridItem(book);
      },
    );
  }

  Widget _buildGridItem(Book book) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to book details
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: book.image != null
                      ? Image.file(
                          File(book.image!),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                              child: const Icon(
                                Icons.book,
                                size: 32,
                                color: Colors.grey,
                              ),
                            );
                          },
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          child: const Icon(
                            Icons.book,
                            size: 32,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ),
            ),
            // Book Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: LibrioTextStyle.smallBody?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      book.auhtor,
                      style: LibrioTextStyle.smallBody?.copyWith(
                        color: Colors.grey[600],
                        fontSize: 11,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(
                          book.statusEnum,
                        ).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        book.statusEnum.displayName,
                        style: LibrioTextStyle.smallBody?.copyWith(
                          color: _getStatusColor(book.statusEnum),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Book> _filterBooks(List<Book> books) {
    return books.where((book) {
      // Search filter
      final matchesSearch =
          _searchQuery.isEmpty ||
          book.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          book.auhtor.toLowerCase().contains(_searchQuery.toLowerCase());

      // Category filter
      final matchesCategory =
          _selectedCategory == null ||
          book.categoriesList.contains(_selectedCategory);

      // Status filter
      final matchesStatus =
          _selectedStatus == null ||
          book.statusEnum.displayName == _selectedStatus;

      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(ReadingStatus status) {
    switch (status) {
      case ReadingStatus.toRead:
        return Colors.grey;
      case ReadingStatus.reading:
        return Colors.blue;
      case ReadingStatus.finished:
        return Colors.green;
    }
  }

  void _showDeleteConfirmation(BuildContext context, int bookId) {
    final provider = context.read<HomeProvider>();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Book'),
          content: const Text('Are you sure you want to delete this book?'),
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
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
