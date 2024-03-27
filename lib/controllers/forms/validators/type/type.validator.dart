import 'package:communitybank/models/data/product/product.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final typeNameProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final typeStakeProvider = StateProvider<double>(
  (ref) {
    return .0;
  },
);

// for managing products inputs, add,hide inputs, identify inputs
final typeAddedInputsProvider = StateProvider<Map<int, bool>>((ref) {
  return {};
});

// store selected items so as to reduce items for the remain dropdowns
final typeSelectedProductsProvider = StateProvider<Map<String, Product>>(
  (ref) {
    return {};
  },
);

final typeProductNumberProvider = StateProvider.family<int, int>(
  (ref, productIndex) {
    return 0;
  },
);

class TypeValidators {
  static String? typeName(String? value, WidgetRef ref) {
    if (ref.watch(typeNameProvider) == '') {
      return 'Entrez le nom d\'un produit';
    } else if (ref.watch(typeNameProvider).length < 3) {
      return "Le nom du produit doit contenir au moins 3 lettres";
    }
    return null;
  }

  static String? typeStack(String? value, WidgetRef ref) {
    if (ref.watch(typeStakeProvider) == .0) {
      return 'Entrez une valeur';
    }
    return null;
  }

  static String? typeProductNumber(
    String? value,
    int productIndex,
    WidgetRef ref,
  ) {
    if (ref.watch(typeProductNumberProvider(productIndex)) == 0) {
      return 'Entrez une valeur';
    }
    return null;
  }
}
