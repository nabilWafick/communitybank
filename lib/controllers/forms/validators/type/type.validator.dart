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
