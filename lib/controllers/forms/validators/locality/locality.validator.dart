import 'package:flutter_riverpod/flutter_riverpod.dart';

final localityNameProvider = StateProvider<String>((ref) {
  return '';
});

class LocalityValidators {
  static String? localityName(String? value, WidgetRef ref) {
    if (ref.watch(localityNameProvider) == '') {
      return 'Entrez le nom d\'une localité';
    } else if (ref.watch(localityNameProvider).length < 3) {
      return "La localité doit contenir au moins 3 lettres";
    }
    return null;
  }
}
