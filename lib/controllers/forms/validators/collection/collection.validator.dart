import 'package:flutter_riverpod/flutter_riverpod.dart';

final collectionAmountProvider = StateProvider<double>(
  (ref) {
    return .0;
  },
);

final collectionCollectionDateProvider = StateProvider<DateTime?>(
  (ref) {
    return;
  },
);

class CollectionValidors {
  static String? collectionNumber(String? value, WidgetRef ref) {
    final collectionNumber = ref.watch(collectionAmountProvider);
    if (collectionNumber == .0) {
      return 'Entrez un montant valide';
    }
    return null;
  }
}
