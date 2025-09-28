import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp/widget/pickeImage.dart';

Future<void> showDialogChooseImage(
  BuildContext context, {
  required Function(File) onImageSelected,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.zero, // يزيل الهوامش الجانبية
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Pikeimage(
              onImageSelected: (file) {
                onImageSelected(file);
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      );
    },
  );
}
