import 'package:communitybank/models/data/product/product.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stockInputedQuantityProvider = StateProvider<int>(
  (ref) {
    return 0;
  },
);

final stockOutputedQuantityProvider = StateProvider<int>(
  (ref) {
    return 0;
  },
);

// for managing products inputs, add,hide inputs, identify inputs
final stockConstrainedOuputAddedInputsProvider =
    StateProvider<Map<int, bool>>((ref) {
  return {};
});

// store selected items so as to reduce items for the remain dropdowns
final stockConstrainedOuputSelectedProductsProvider =
    StateProvider<Map<String, Product>>(
  (ref) {
    return {};
  },
);

final stockConstrainedOuputProductNumberProvider =
    StateProvider.family<int, int>(
  (ref, productIndex) {
    return 0;
  },
);

class StockValidators {
  static String? stockManualInputedQuantity(String? value, WidgetRef ref) {
    final inputedQuantity = ref.watch(stockInputedQuantityProvider);
    if (inputedQuantity < 1) {
      return 'Entrez un nombre valide';
    }
    return null;
  }

  static String? stockManualOutputedQuantity(String? value, WidgetRef ref) {
    final outputedQuantity = ref.watch(stockOutputedQuantityProvider);
    if (outputedQuantity < 1) {
      return 'Entrez un nombre valide';
    }
    return null;
  }

  static String? stockConstrainedOuputProductNumber(
    String? value,
    int productIndex,
    WidgetRef ref,
  ) {
    if (ref.watch(stockConstrainedOuputProductNumberProvider(productIndex)) ==
        0) {
      return 'Entrez une valeur';
    }
    return null;
  }
}
