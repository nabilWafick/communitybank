import 'package:flutter_riverpod/flutter_riverpod.dart';

final productNameProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final productPurchasePriceProvider = StateProvider<double>(
  (ref) {
    return .0;
  },
);

final productPictureProvider = StateProvider<String?>(
  (ref) {
    return '';
  },
);
