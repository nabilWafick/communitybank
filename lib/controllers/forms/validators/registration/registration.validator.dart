import 'package:flutter_riverpod/flutter_riverpod.dart';

final newUserEmailProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final newUserPasswordProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

class RegistrationValidators {
  static String? newUserEmail(String? value, WidgetRef ref) {
    if (!isValidEmail(ref.watch(newUserEmailProvider))) {
      return 'Entrez un email valide';
    }
    return null;
  }

  static String? newUserPassword(String? value, WidgetRef ref) {
    if (ref.watch(newUserPasswordProvider) == '') {
      return 'Entrez votre mot de  passe ';
    } else if (ref.watch(newUserPasswordProvider).length < 7) {
      return "Le mot de  passe doit contenir au moins 7 lettres";
    }
    return null;
  }

  static bool isValidEmail(String email) {
    RegExp emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    return emailRegExp.hasMatch(email);
  }
}
