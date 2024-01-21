import 'package:flutter_riverpod/flutter_riverpod.dart';

final userEmailProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final userPasswordProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

class LoginValidators {
  static String? userEmail(String? value, WidgetRef ref) {
    if (!isValidEmail(ref.watch(userEmailProvider))) {
      return 'Entrez un email valide';
    }
    return null;
  }

  static String? userPassword(String? value, WidgetRef ref) {
    if (ref.watch(userPasswordProvider) == '') {
      return 'Entrez votre mot de  passe ';
    } else if (ref.watch(userPasswordProvider).length < 7) {
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
