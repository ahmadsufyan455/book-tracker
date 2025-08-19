import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:librio/core/enum/reading_status_enum.dart';
import 'package:librio/core/ext/ext_context.dart';
import 'package:librio/core/theme/app_colors.dart';
import 'package:librio/core/theme/text_styles.dart';
import 'package:librio/data/local/entities/book.dart';
import 'package:librio/presentation/common_widgets/common_app_bar.dart';
import 'package:librio/presentation/common_widgets/linear_progress.dart';
import 'package:librio/presentation/pages/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

@RoutePage()
class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: 'Reading Stats',
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

          final books = snapshot.data ?? [];
          return _buildStatsContent(context, books);
        },
      ),
    );
  }

  Widget _buildStatsContent(BuildContext context, List<Book> books) {
    final stats = _calculateStats(books);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overview Cards
          _buildOverviewCards(context, stats),
          const SizedBox(height: 24),

          // Reading Progress
          _buildReadingProgress(context, stats),
          const SizedBox(height: 24),

          // Status Breakdown
          _buildStatusBreakdown(context, stats),
          const SizedBox(height: 24),

          // Recent Activity
          _buildRecentActivity(context, books),
        ],
      ),
    );
  }

  Widget _buildOverviewCards(BuildContext context, Map<String, dynamic> stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: LibrioTextStyle.headline?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                'Total Books',
                '${stats['totalBooks']}',
                Icons.library_books,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                context,
                'Completed',
                '${stats['completedBooks']}',
                Icons.check_circle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                'Currently Reading',
                '${stats['currentlyReading']}',
                Icons.book,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                context,
                'To Read',
                '${stats['toRead']}',
                Icons.bookmark,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    final colorScheme = context.theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: colorScheme.brightness == Brightness.dark ? 0.2 : 0.1,
            ),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.librioBlue, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: LibrioTextStyle.headline?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.librioBlue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: LibrioTextStyle.smallBody?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildReadingProgress(
    BuildContext context,
    Map<String, dynamic> stats,
  ) {
    final colorScheme = context.theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reading Progress',
          style: LibrioTextStyle.headline?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: colorScheme.brightness == Brightness.dark ? 0.2 : 0.1,
                ),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Monthly Goal', style: LibrioTextStyle.bodyBold),
                  Text(
                    '${stats['completedThisMonth']} / ${stats['monthlyGoal']}',
                    style: LibrioTextStyle.bodyBold?.copyWith(
                      color: AppColors.librioBlue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              LinearProgress(progress: stats['monthlyProgress']),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Yearly Goal', style: LibrioTextStyle.bodyBold),
                  Text(
                    '${stats['completedThisYear']} / ${stats['yearlyGoal']}',
                    style: LibrioTextStyle.bodyBold?.copyWith(
                      color: Colors.green[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              LinearProgress(
                progress: stats['yearlyProgress'],
                valueColor: Colors.green[600],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBreakdown(
    BuildContext context,
    Map<String, dynamic> stats,
  ) {
    final colorScheme = context.theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Status Breakdown',
          style: LibrioTextStyle.headline?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: colorScheme.brightness == Brightness.dark ? 0.2 : 0.1,
                ),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildStatusItem(
                'Completed',
                stats['completedBooks'],
                Colors.green,
                Icons.check_circle,
              ),
              const SizedBox(height: 12),
              _buildStatusItem(
                'Currently Reading',
                stats['currentlyReading'],
                AppColors.librioBlue,
                Icons.book,
              ),
              const SizedBox(height: 12),
              _buildStatusItem(
                'To Read',
                stats['toRead'],
                colorScheme.onSurface.withValues(alpha: 0.6),
                Icons.bookmark,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusItem(
    String status,
    int count,
    Color color,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(status, style: LibrioTextStyle.body)),
        Text('$count', style: LibrioTextStyle.bodyBold?.copyWith(color: color)),
      ],
    );
  }

  Widget _buildRecentActivity(BuildContext context, List<Book> books) {
    final colorScheme = context.theme.colorScheme;

    final recentBooks =
        books
            .where((book) => book.statusEnum == ReadingStatus.finished)
            .toList()
          ..sort((a, b) => b.updatedAtDateTime.compareTo(a.updatedAtDateTime));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recently Completed',
          style: LibrioTextStyle.headline?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        if (recentBooks.isEmpty)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: colorScheme.brightness == Brightness.dark
                        ? 0.2
                        : 0.1,
                  ),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 48,
                    color: colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No completed books yet',
                    style: LibrioTextStyle.body?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: colorScheme.brightness == Brightness.dark
                        ? 0.2
                        : 0.1,
                  ),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recentBooks.take(5).length,
              itemBuilder: (context, index) {
                final book = recentBooks[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green[100],
                    child: Icon(
                      Icons.check,
                      color: Colors.green[600],
                      size: 16,
                    ),
                  ),
                  title: Text(book.title, style: LibrioTextStyle.bodyBold),
                  subtitle: Text(
                    'Completed on ${_formatDate(book.updatedAtDateTime)}',
                    style: LibrioTextStyle.smallBody?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Map<String, dynamic> _calculateStats(List<Book> books) {
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    final completedBooks = books
        .where((book) => book.statusEnum == ReadingStatus.finished)
        .length;
    final currentlyReading = books
        .where((book) => book.statusEnum == ReadingStatus.reading)
        .length;
    final toRead = books
        .where((book) => book.statusEnum == ReadingStatus.toRead)
        .length;

    final completedThisMonth = books.where((book) {
      final updatedDate = book.updatedAtDateTime;
      return book.statusEnum == ReadingStatus.finished &&
          updatedDate.month == currentMonth &&
          updatedDate.year == currentYear;
    }).length;

    final completedThisYear = books.where((book) {
      final updatedDate = book.updatedAtDateTime;
      return book.statusEnum == ReadingStatus.finished &&
          updatedDate.year == currentYear;
    }).length;

    // Default goals (can be made configurable later)
    const monthlyGoal = 3;
    const yearlyGoal = 24;

    return {
      'totalBooks': books.length,
      'completedBooks': completedBooks,
      'currentlyReading': currentlyReading,
      'toRead': toRead,
      'completedThisMonth': completedThisMonth,
      'completedThisYear': completedThisYear,
      'monthlyGoal': monthlyGoal,
      'yearlyGoal': yearlyGoal,
      'monthlyProgress': completedThisMonth / monthlyGoal,
      'yearlyProgress': completedThisYear / yearlyGoal,
    };
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
