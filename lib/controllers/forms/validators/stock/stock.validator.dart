import 'package:flutter_riverpod/flutter_riverpod.dart';

final inputedQuantityProvider = StateProvider<int>(
  (ref) {
    return 0;
  },
);

final outputedQuantityProvider = StateProvider<int>(
  (ref) {
    return 0;
  },
);

class StockValidators {
  static String? inputedQuantity(String? value, WidgetRef ref) {
    final inputedQuantity = ref.watch(inputedQuantityProvider);
    if (inputedQuantity < 1) {
      return 'Entrez un nombre valide';
    }
    return null;
  }

   static String? outputedQuantity(String? value, WidgetRef ref) {
    final outputedQuantity = ref.watch(outputedQuantityProvider);
    if (outputedQuantity < 1) {
      return 'Entrez un nombre valide';
    }
    return null;
  }
}
