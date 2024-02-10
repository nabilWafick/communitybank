import 'package:flutter_riverpod/flutter_riverpod.dart';

final personalStatusNameProvider = StateProvider<String>((ref) {
  return '';
});

class PersonalStatusValidators {
  static String? personalStatusName(String? value, WidgetRef ref) {
    if (ref.watch(personalStatusNameProvider).trim() == '') {
      return 'Entrez le nom d\'un status personnel';
    } else if (ref.watch(personalStatusNameProvider).length < 3) {
      return "Le status personnel doit contenir au moins 3 lettres";
    }
    return null;
  }
}

/*

static String? personalStatusName(String? value, WidgetRef ref) {
    if (ref.watch(personalStatusNameProvider).trim() == '') {
      return 'Entrez un nom de parcours';
    } else if (ref.watch(personalStatusNameProvider).length < 3) {
      return "Le nom du parcours doit contenir au moins trois caractères";
    }
    return null;
  }

*/

/*

 static String? nomParcours(String? value, WidgetRef ref) {
    if (ref.watch(nomParcoursProvider).trim() == '') {
      return 'Entrez un nom de parcours';
    } else if (ref.watch(nomParcoursProvider).length < 3) {
      return "Le nom du parcours doit contenir au moins trois caractères";
    }
    return null;
  }

  static String? lineaireTotale(String? value, WidgetRef ref) {
    if (ref.watch(lineaireTotaleProvider) == .0) {
      return 'Entrez une valeur';
    }
    return null;
  }

  static String? longueurBande(String? value, WidgetRef ref) {
    if (ref.watch(longueurBandeProvider) == .0) {
      return 'Entrez une valeur';
    }
    return null;
  }

*/