import 'package:flutter_riverpod/flutter_riverpod.dart';

final customerCardLabelProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final customerCardSatisfactionDateProvider = StateProvider<DateTime?>(
  (ref) {
    return;
  },
);

final customerCardRepaymentDateProvider = StateProvider<DateTime?>(
  (ref) {
    return;
  },
);

class CustomerCardValidators {
  static String? customerCardLabel(String? value, WidgetRef ref) {
    if (ref.watch(customerCardLabelProvider) == '') {
      return 'Entrez le libellé de l\'customerCard';
    } else if (ref.watch(customerCardLabelProvider).length < 3) {
      return "Le nom doit contenir au moins 5 lettres";
    }
    return null;
  }
}
