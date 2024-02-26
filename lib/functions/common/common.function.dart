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
      barrierDismissible: false,
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

  static showDateTime(BuildContext context, WidgetRef ref,
      StateProvider<DateTime?> stateProvider) async {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;
    //  do {
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
    //  } while (selectedDate == null || selectedTime == null);

    DateTime? dateTime;

    if (selectedDate != null) {
      dateTime = DateTime.now();
      dateTime = dateTime.copyWith(
        year: selectedDate.year,
        month: selectedDate.month,
        day: selectedDate.day,
      );

      dateTime = dateTime.copyWith(
        hour: selectedTime != null ? selectedTime.hour : 0,
        minute: selectedTime != null ? selectedTime.minute : 0,
      );
    }

    ref.read(stateProvider.notifier).state = dateTime != null
        ? DateTime(
            dateTime.year,
            dateTime.month,
            dateTime.day,
            dateTime.hour,
            dateTime.minute,
          )
        : null;
  }

  static String getFormatedTime({
    required DateTime dateTime,
  }) {
    String hour =
        dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour.toString();
    String minute = dateTime.minute < 10
        ? '0${dateTime.minute}'
        : dateTime.minute.toString();
    String second = dateTime.second < 10
        ? '0${dateTime.second}'
        : dateTime.second.toString();
    return '$hour:$minute:$second';
  }

  static String getSQLFormatDate(DateTime dateTime) {
    String year = dateTime.year.toString().padLeft(4, '0');
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');
    return "$year-$month-$day";
  }
}
