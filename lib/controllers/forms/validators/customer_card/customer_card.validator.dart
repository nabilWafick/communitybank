import 'package:flutter_riverpod/flutter_riverpod.dart';

final cardLabelProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final cardSatisfactionDateProvider = StateProvider<DateTime?>(
  (ref) {
    return;
  },
);

final cardRepaymentDateProvider = StateProvider<DateTime?>(
  (ref) {
    return;
  },
);

class CardValidors {
  static String? cardLabel(String? value, WidgetRef ref) {
    if (ref.watch(cardLabelProvider) == '') {
      return 'Entrez le libellé de l\'card';
    } else if (ref.watch(cardLabelProvider).length < 3) {
      return "Le nom doit contenir au moins 5 lettres";
    }
    return null;
  }
}
