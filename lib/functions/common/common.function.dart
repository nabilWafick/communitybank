// ignore_for_file: use_build_context_synchronously

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FunctionsController {
  static showAlertDialog({
    required BuildContext context,
    required Widget alertDialog,
  }) {
    showDialog(
      context: context,
      builder: (context) => alertDialog,
    );
  }

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

  static showDateTime(
      BuildContext context, WidgetRef ref, StateProvider stateProvider) async {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;
    do {
      selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        locale: const Locale('fr', 'FR'),
        firstDate: DateTime(2010),
        lastDate: DateTime(20100),
        confirmText: 'Valider',
        cancelText: 'Annuler',
      );

      selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        confirmText: 'Valider',
        cancelText: 'Annuler',
      );
    } while (selectedDate == null || selectedTime == null);

    ref.read(stateProvider.notifier).state = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }
}
