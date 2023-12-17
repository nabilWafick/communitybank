import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FunctionsController {
  static Future<String?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      // debugPrint('Picked File: ${result.files.single.path!}');
      return result.files.single.path!;
    } else {
      return null;
    }
  }
}
