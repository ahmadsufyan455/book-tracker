import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:librio/core/enum/reading_status_enum.dart';
import 'package:librio/core/widgets/common_textfield.dart';

class AddBookFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController authorController;
  final TextEditingController isbnController;
  final TextEditingController publisherController;
  final TextEditingController totalPagesController;
  final TextEditingController descriptionController;
  final TextEditingController currentPageController;
  final TextEditingController notesController;
  final ReadingStatus selectedStatus;

  const AddBookFormFields({
    super.key,
    required this.titleController,
    required this.authorController,
    required this.isbnController,
    required this.publisherController,
    required this.totalPagesController,
    required this.descriptionController,
    required this.currentPageController,
    required this.notesController,
    required this.selectedStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTextfield(
          label: 'Book Title',
          controller: titleController,
          hintText: 'Enter the book title...',
          prefixIcon: Icons.book,
          isRequired: true,
        ),
        const Gap(16),
        CommonTextfield(
          label: 'Author',
          controller: authorController,
          hintText: 'Enter the author name...',
          prefixIcon: Icons.person,
          isRequired: true,
        ),
        const Gap(16),
        CommonTextfield(label: 'ISBN', controller: isbnController),
        const Gap(16),
        CommonTextfield(label: 'Publisher', controller: publisherController),
        const Gap(16),
        _buildConditionalFields(),
        CommonTextfield(
          label: 'Total Pages',
          controller: totalPagesController,
          isRequired: true,
        ),
        const Gap(16),
        CommonTextfield(
          label: 'Description',
          controller: descriptionController,
          maxLines: 20,
          hintText: 'Enter a brief description of the book...',
          prefixIcon: Icons.description,
          textInputAction: TextInputAction.newline,
          minLines: 1,
        ),
      ],
    );
  }

  Widget _buildConditionalFields() {
    if (selectedStatus == ReadingStatus.reading) {
      return Column(
        children: [
          CommonTextfield(
            label: 'Current Page',
            controller: currentPageController,
            hintText: 'Enter current page number...',
            prefixIcon: Icons.bookmark,
            keyboardType: TextInputType.number,
          ),
          const Gap(16),
        ],
      );
    }

    if (selectedStatus == ReadingStatus.finished) {
      return Column(
        children: [
          CommonTextfield(
            label: 'Book Notes',
            controller: notesController,
            maxLines: 5,
            hintText: 'Share your thoughts about the book...',
            prefixIcon: Icons.note,
            textInputAction: TextInputAction.newline,
            minLines: 3,
          ),
          const Gap(16),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
