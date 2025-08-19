import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:librio/core/ext/ext_context.dart';
import 'package:librio/core/ext/ext_string.dart';
import 'package:librio/core/theme/text_styles.dart';
import 'package:librio/core/utils/add_category_dialog.dart';
import 'package:librio/data/local/entities/book.dart';
import 'package:librio/data/local/entities/book_category.dart';
import 'package:librio/presentation/common_widgets/app_button.dart';
import 'package:librio/presentation/common_widgets/common_app_bar.dart';
import 'package:librio/presentation/pages/add/models/add_book_form_data.dart';
import 'package:librio/presentation/pages/add/provider/add_book_form_provider.dart';
import 'package:librio/presentation/pages/add/provider/add_book_provider.dart';
import 'package:librio/presentation/pages/add/provider/add_category_provider.dart';
import 'package:librio/presentation/pages/add/services/add_book_validation_service.dart';
import 'package:librio/presentation/pages/add/widgets/add_book_cover.dart';
import 'package:librio/presentation/pages/add/widgets/add_book_form_fields.dart';
import 'package:librio/presentation/pages/add/widgets/add_book_selection_section.dart';
import 'package:provider/provider.dart';

@RoutePage()
class AddBookPage extends StatefulWidget {
  final Book? book;
  const AddBookPage({super.key, this.book});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  late AddBookFormProvider formProvider;

  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _isbnController = TextEditingController();
  final _publisherController = TextEditingController();
  final _totalpagesController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _currentPageController = TextEditingController();
  final _notesController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    formProvider = Provider.of<AddBookFormProvider>(context, listen: false);
    _initializeForm();
  }

  void _initializeForm() {
    if (widget.book != null) {
      _populateFormForEdit(widget.book!);
    } else {
      formProvider.resetForm();
    }
  }

  void _populateFormForEdit(Book book) {
    _titleController.text = book.title;
    _authorController.text = book.auhtor;
    _isbnController.text = book.isbn.orEmpty;
    _publisherController.text = book.publisher.orEmpty;
    _totalpagesController.text = book.totalPages.toString();
    _descriptionController.text = book.description.orEmpty;
    _currentPageController.text = (book.currentPage?.toString()).orEmpty;
    _notesController.text = book.notes.orEmpty;

    formProvider.imagePath = book.image;
    formProvider.clearCategories();
    for (final cat in book.categoriesList) {
      formProvider.addCategory(cat);
    }
    formProvider.setStatusFromString(book.status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: widget.book != null ? 'Edit Book' : 'Add Book',
        showBackButton: true,
        showHelpButton: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const AddBookCover(),
            const Gap(16),
            Consumer<AddBookFormProvider>(
              builder: (context, formProvider, child) {
                return AddBookFormFields(
                  titleController: _titleController,
                  authorController: _authorController,
                  isbnController: _isbnController,
                  publisherController: _publisherController,
                  totalPagesController: _totalpagesController,
                  descriptionController: _descriptionController,
                  currentPageController: _currentPageController,
                  notesController: _notesController,
                  selectedStatus: formProvider.selectedStatus,
                );
              },
            ),
            const Gap(16),
            buildCategorySelection(),
            const Gap(16),
            buildReadingStatusSelection(),
            const Gap(32),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget buildCategorySelection() {
    return Consumer<AddBookFormProvider>(
      builder: (context, formProvider, child) {
        return StreamBuilder<List<BookCategory>>(
          stream: context.read<AddCategoryProvider>().categories,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('No category found!', style: LibrioTextStyle.body);
            }
            final categories = snapshot.data?.map((e) => e.name).toList() ?? [];
            final selectedStates = categories
                .map((category) => formProvider.isCategorySelected(category))
                .toList();

            return AddBookSelectionSection(
              title: 'Categories',
              icon: Icons.category,
              options: categories,
              showAddButton: true,
              selectedStates: selectedStates,
              onTap: (index) => formProvider.toggleCategory(categories[index]),
              helperText: formProvider.selectedCategories.isEmpty
                  ? 'Select one or more categories'
                  : null,
              showHelperText: formProvider.selectedCategories.isEmpty,
              onAddTap: () => AddCategoryDialog.show(
                context: context,
                controller: _categoryController,
                onSave: () {
                  if (_categoryController.text.isEmpty) {
                    context.showMessageToast(message: 'Name is required');
                    return;
                  }
                  final category = BookCategory(name: _categoryController.text);
                  context.read<AddCategoryProvider>().addCategory(category);
                  context.maybePop();
                  _categoryController.clear();
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget buildReadingStatusSelection() {
    return Consumer<AddBookFormProvider>(
      builder: (context, formProvider, child) {
        final statusOptions = formProvider.statusOptions;
        final selectedStates = statusOptions
            .map((status) => formProvider.isStatusSelected(status))
            .toList();

        return AddBookSelectionSection(
          title: 'Reading Status',
          icon: Icons.book,
          options: statusOptions.map((status) => status.displayName).toList(),
          selectedStates: selectedStates,
          onTap: (index) => formProvider.setStatus(statusOptions[index]),
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return Consumer<AddBookProvider>(
      builder: (_, provider, _) {
        VoidCallback? action = provider.isLoading ? null : _onSubmit;
        return AppButton(
          onPressed: action,
          child: provider.isLoading
              ? const CircularProgressIndicator()
              : Text(widget.book == null ? 'Add Book' : 'Update Book'),
        );
      },
    );
  }

  Future<void> _onSubmit() async {
    final provider = context.read<AddBookProvider>();

    final formData = AddBookFormData(
      title: _titleController.text,
      author: _authorController.text,
      isbn: _isbnController.text,
      publisher: _publisherController.text,
      totalPages: _totalpagesController.text,
      description: _descriptionController.text,
      currentPage: _currentPageController.text,
      notes: _notesController.text,
    );

    // Validate form
    final validationError = _validateForm(formData);
    if (validationError != null) {
      context.showMessageToast(message: validationError);
      return;
    }

    // Create book object
    final book = formData.toBook(
      id: widget.book?.id,
      image: formProvider.imagePath,
      categories: formProvider.selectedCategories.join(', '),
      status: formProvider.selectedStatus.displayName,
      currentPage: formData.currentPageAsInt,
    );

    // Submit
    final success = widget.book == null
        ? await provider.addBook(book)
        : await provider.updateBook(book);

    if (!mounted) return;

    if (success) {
      _resetForm();
      context.showMessageToast(
        message: widget.book == null
            ? 'Book added successfully!'
            : 'Book updated successfully!',
      );
      context.back();
    } else {
      context.showMessageToast(message: provider.errorMessage);
    }
  }

  String? _validateForm(AddBookFormData formData) {
    // Required fields
    final requiredError = AddBookValidationService.validateRequiredFields(
      title: formData.trimmedTitle,
      author: formData.trimmedAuthor,
    );
    if (requiredError != null) return requiredError;

    // Total pages
    final pagesError = AddBookValidationService.validateTotalPages(
      formData.trimmedTotalPages,
    );
    if (pagesError != null) return pagesError;

    // Current page
    final currentPageError = AddBookValidationService.validateCurrentPage(
      currentPageText: formData.trimmedCurrentPage,
      status: formProvider.selectedStatus,
      totalPages: formData.totalPagesAsInt,
    );
    if (currentPageError != null) return currentPageError;

    return null;
  }

  void _resetForm() {
    formProvider.resetForm();
    _titleController.clear();
    _authorController.clear();
    _isbnController.clear();
    _publisherController.clear();
    _totalpagesController.clear();
    _descriptionController.clear();
    _currentPageController.clear();
    _notesController.clear();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _isbnController.dispose();
    _publisherController.dispose();
    _totalpagesController.dispose();
    _descriptionController.dispose();
    _currentPageController.dispose();
    _notesController.dispose();
    _categoryController.dispose();
    super.dispose();
  }
}
