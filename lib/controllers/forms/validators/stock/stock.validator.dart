import 'package:flutter_riverpod/flutter_riverpod.dart';

final stockQuantityProvider = StateProvider<int>(
  (ref) {
    return 0;
  },
);

class StockValidators {
  static String? stockQuantity(String? value, WidgetRef ref) {
    final stockQuantity = ref.watch(stockQuantityProvider);
    if (stockQuantity < 1) {
      return 'Entrez un nombre valide';
    }
    return null;
  }
}
