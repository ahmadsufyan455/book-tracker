import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:librio/core/ext/ext_context.dart';
import 'package:librio/core/theme/text_styles.dart';
import 'package:librio/core/utils/common_asset.dart';
import 'package:librio/gen/assets.gen.dart';
import 'package:librio/presentation/pages/add/provider/add_book_form_provider.dart';
import 'package:provider/provider.dart';

class AddBookCover extends StatelessWidget {
  const AddBookCover({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showImageSourceActionSheet(context),
      child: _buildImagePreview(context),
    );
  }

  Widget _buildImagePreview(BuildContext context) {
    return Consumer<AddBookFormProvider>(
      builder: (_, value, _) {
        final imagePath = value.imagePath;
        if (imagePath == null ||
            imagePath.isEmpty ||
            !File(imagePath).existsSync()) {
          return DottedBorder(
            options: RectDottedBorderOptions(
              padding: const EdgeInsets.all(20),
              color: context.theme.colorScheme.outline.withValues(alpha: 0.2),
              strokeWidth: 2,
              dashPattern: const [10, 5],
            ),
            child: Container(
              alignment: Alignment.center,
              height: 140,
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonAsset.loadSvg(
                    assetName: Assets.icons.addImage,
                    width: 40,
                    height: 40,
                  ),
                  Text(
                    'Book Cover',
                    style: LibrioTextStyle.smallBody?.copyWith(
                      color: context.theme.colorScheme.onSurface.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            File(imagePath),
            height: 140,
            width: 100,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  Future<void> _showImageSourceActionSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  context.maybePop();
                  context.read<AddBookFormProvider>().pickImage(
                    ImageSource.camera,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  context.maybePop();
                  context.read<AddBookFormProvider>().pickImage(
                    ImageSource.gallery,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
