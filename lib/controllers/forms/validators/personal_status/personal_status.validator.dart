import 'package:flutter_riverpod/flutter_riverpod.dart';

final personalStatusNameProvider = StateProvider<String>((ref) {
  return '';
});

/*

 static String? nomParcours(String? value, WidgetRef ref) {
    if (ref.watch(nomParcoursProvider) == '') {
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