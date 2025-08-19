import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:librio/app_router.gr.dart';
import 'package:librio/core/ext/ext_context.dart';
import 'package:librio/core/ext/ext_string.dart';
import 'package:librio/data/local/entities/book.dart';
import 'package:librio/gen/assets.gen.dart';
import 'package:librio/presentation/common_widgets/linear_progress.dart';

class BookItem extends StatelessWidget {
  final Book book;

  const BookItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final totalPages = book.totalPages;
    final currentPage = book.currentPage ?? 0;
    double progress = 0;
    if (totalPages > 0 && currentPage > 0) {
      progress = (currentPage / totalPages).clamp(0.0, 1.0);
    }

    return GestureDetector(
      onTap: () {
        context.pushRoute(AddBookRoute(book: book));
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.theme.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: _buildBookImage(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book.auhtor,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      book.categories.orEmpty,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    if (totalPages > 0 && currentPage > 0)
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Expanded(child: LinearProgress(progress: progress)),
                            const SizedBox(width: 8),
                            Text(
                              '${(progress * 100).round()}%',
                              style: context.theme.textTheme.bodySmall
                                  ?.copyWith(
                                    color: context.theme.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookImage() {
    if (book.image == null || book.image!.isEmpty) {
      return _buildPlaceholderImage();
    }

    return Image.file(
      File(book.image!),
      width: 80,
      height: 120,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return _buildPlaceholderImage();
      },
    );
  }

  Widget _buildPlaceholderImage() {
    return Image.asset(
      Assets.images.placeholder.path,
      width: 80,
      height: 120,
      fit: BoxFit.cover,
    );
  }
}
