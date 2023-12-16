import 'package:flutter_riverpod/flutter_riverpod.dart';

final economicalActivityNameProvider = StateProvider<String>((ref) {
  return '';
});

class EconomicalActivityValidators {
  static String? economicalActivityName(String? value, WidgetRef ref) {
    if (ref.watch(economicalActivityNameProvider) == '') {
      return 'Entrez le nom d\'une activité économique';
    } else if (ref.watch(economicalActivityNameProvider).length < 3) {
      return "L'activité économique doit contenir au moins 3 lettres";
    }
    return null;
  }
}
