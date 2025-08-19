import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:librio/core/enum/reading_status_enum.dart';
import 'package:librio/core/utils/image_cropper_helper.dart';

@injectable
class AddBookFormProvider extends ChangeNotifier {
  // Image path
  String? imagePath;
  XFile? pickedFile;

  // Category selection
  final Set<String> _selectedCategories = {};

  // Reading status
  ReadingStatus _selectedStatus = ReadingStatus.toRead;

  // Getters
  Set<String> get selectedCategories => _selectedCategories;
  ReadingStatus get selectedStatus => _selectedStatus;
  List<ReadingStatus> get statusOptions => ReadingStatus.values;

  void _setImage(XFile? value) {
    pickedFile = value;
    imagePath = value?.path;
    notifyListeners();
  }

  void pickImage(ImageSource source) async {
    final picker = ImagePicker();

    pickedFile = await picker.pickImage(source: source);
    _cropImage();
  }

  Future<void> _cropImage() async {
    if (pickedFile != null) {
      final croppedPath = await ImageCropperHelper.cropImage(
        imagePath: pickedFile!.path,
      );

      if (croppedPath != null) {
        _setImage(XFile(croppedPath));
      }
    }
  }

  // Category management
  void toggleCategory(String category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    notifyListeners();
  }

  void addCategory(String category) {
    _selectedCategories.add(category);
    notifyListeners();
  }

  void removeCategory(String category) {
    _selectedCategories.remove(category);
    notifyListeners();
  }

  void clearCategories() {
    _selectedCategories.clear();
    notifyListeners();
  }

  bool isCategorySelected(String category) {
    return _selectedCategories.contains(category);
  }

  // Status management
  void setStatus(ReadingStatus status) {
    _selectedStatus = status;
    notifyListeners();
  }

  void setStatusFromString(String statusString) {
    _selectedStatus = ReadingStatus.fromString(statusString);
    notifyListeners();
  }

  bool isStatusSelected(ReadingStatus status) {
    return _selectedStatus == status;
  }

  bool get isFormValid {
    return _selectedCategories.isNotEmpty;
  }

  void resetForm() {
    _selectedCategories.clear();
    _selectedStatus = ReadingStatus.toRead;
    imagePath = null;
    pickedFile = null;
    notifyListeners();
  }

  Map<String, dynamic> getFormData() {
    return {
      'categories': _selectedCategories.toList(),
      'status': _selectedStatus.displayName,
    };
  }
}
