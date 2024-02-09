import 'package:flutter_riverpod/flutter_riverpod.dart';

final customerCardLabelProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final customerCardTypeNumberProvider = StateProvider<int>(
  (ref) {
    return 0;
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

  static String? customerCardTypeNumber(String? value, WidgetRef ref) {
    if (ref.watch(customerCardTypeNumberProvider) == 0) {
      return 'Entrez un nombre valide';
    }
    return null;
  }
}
