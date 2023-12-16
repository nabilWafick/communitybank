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

final typeProductsProvider = StateProvider<List<Product>>(
  (ref) {
    return [];
  },
);

final typeProductProvider = StateProvider.family<Product?, String>(
  (ref, productName) {
    return;
  },
);

final typeProductNumberProvider = StateProvider.family<int, int>(
  (ref, productName) {
    return 1;
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
}
