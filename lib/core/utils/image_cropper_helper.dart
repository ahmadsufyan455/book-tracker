import 'package:image_cropper/image_cropper.dart';
import 'package:librio/core/theme/app_colors.dart';

sealed class ImageCropperHelper {
  static Future<String?> cropImage({required String imagePath}) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: AppColors.librioBlue,
          toolbarWidgetColor: AppColors.librioLightSurface,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPresetCustom(),
          ],
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPresetCustom(),
          ],
        ),
      ],
    );

    return croppedFile?.path;
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}
