import 'package:flutter_riverpod/flutter_riverpod.dart';

bool hasSpecialCharactersOrLettersForInt(String value) {
  final specialCharacters = RegExp(r'[!@#$%^&*(), .?"/:{}|<>]');
  final hasSpecialCharacters = specialCharacters.hasMatch(value);

  final letters = RegExp(r'[a-zA-Z]');
  final hasLetters = letters.hasMatch(value);

  return hasSpecialCharacters || hasLetters;
}

bool hasSpecialCharactersOrLettersForDouble(String value) {
  final specialCharacters = RegExp(r'[!@#$%^&*(), ?"/:{}|<>]');
  final hasSpecialCharacters = specialCharacters.hasMatch(value);

  final letters = RegExp(r'[a-zA-Z]');
  final hasLetters = letters.hasMatch(value);

  return hasSpecialCharacters || hasLetters;
}

class CBCommonOnChangedFunction {
  static void onIntTextInputValueChanged(
      String? value, WidgetRef ref, StateProvider provider) {
    if (value == null ||
        value.isEmpty ||
        value == ' ' ||
        !hasSpecialCharactersOrLettersForInt(value)) {
      ref.read(provider.notifier).state = int.tryParse(value!) ?? 0;
    }
  }

  static void onDoubleTextInputValueChanged(
      String? value, WidgetRef ref, StateProvider provider) {
    if (value == null ||
        value.isEmpty ||
        value == ' ' ||
        !hasSpecialCharactersOrLettersForDouble(value)) {
      ref.read(provider.notifier).state = double.tryParse(value!) ?? .0;
    }
  }

  static void onStringTextInputValueChanged(
      String? value, WidgetRef ref, StateProvider provider) {
    if (value == null || value.isEmpty || value == ' ') {
      ref.read(provider.notifier).state = '';
    }
    ref.read(provider.notifier).state = value;
  }
}
