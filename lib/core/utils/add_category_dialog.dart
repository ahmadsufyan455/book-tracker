import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:librio/core/widgets/common_textfield.dart';

class AddCategoryDialog {
  static void show({
    required BuildContext context,
    required TextEditingController controller,
    required Function() onSave,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Book Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonTextfield(label: 'Category Name', controller: controller),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.clear();
                context.maybePop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(onPressed: onSave, child: const Text('Add')),
          ],
        );
      },
    );
  }
}
