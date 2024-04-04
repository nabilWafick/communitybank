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

  static showDateTime({
    required BuildContext context,
    required WidgetRef ref,
    required StateProvider<DateTime?> stateProvider,
  }) async {
    DateTime? selectedDate;
    //  TimeOfDay? selectedTime;
    //  do {
    selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      locale: const Locale('fr', 'FR'),
      firstDate: DateTime(2010),
      lastDate: DateTime(20500),
      confirmText: 'Valider',
      cancelText: 'Annuler',
    );
/*
    selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      confirmText: 'Valider',
      cancelText: 'Annuler',
    );
    */
    //  } while (selectedDate == null || selectedTime == null);

    DateTime? dateTime;

    if (selectedDate != null) {
      dateTime = DateTime.now();
      dateTime = dateTime.copyWith(
        year: selectedDate.year,
        month: selectedDate.month,
        day: selectedDate.day,
        hour: 0,
        minute: 0,
        second: 0,
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

  static String getSQLFormatDate({
    required DateTime dateTime,
  }) {
    String year = dateTime.year.toString().padLeft(4, '0');
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');
    return "$year-$month-$day";
  }

  static String truncateText({
    required String text,
    required int maxLength,
  }) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return "${text.substring(0, maxLength)}...";
    }
  }

  static String formatLargeNumber({
    required num number,
    required bool ceil,
  }) {
    if (number / 1000000000 >= 1) {
      return number.toInt().remainder(1000000000) != 0
          ? '${((number / 1000000000).toStringAsFixed(2)).replaceFirst(r'.', r',')}Md'
          : '${(number / 1000000000).toStringAsFixed(0)}Md';
    } else if (number / 1000000 >= 1) {
      return number.toInt().remainder(1000000) != 0
          ? '${((number / 1000000).toStringAsFixed(2)).replaceFirst(r'.', r',')}M'
          : '${(number / 1000000).toStringAsFixed(0)}M';
    } else if (number / 1000 >= 1) {
      return number.toInt().remainder(1000) != 0
          ? '${((number / 1000).toStringAsFixed(2)).replaceFirst(r'.', r',')}K'
          : '${(number / 1000).toStringAsFixed(0)}K';
    } else {
      // ceil is used for checking if the value passed will be rounded or
      // not since va,ue on database are storing as decimal. So, value like 1200.0 are getting so it is nec dividing
      return ceil
          ? number.toInt().toString()
          : number.toStringAsFixed(2).replaceFirst(r'.', r',');
    }
  }
}
