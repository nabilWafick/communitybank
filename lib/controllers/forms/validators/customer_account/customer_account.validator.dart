import 'package:communitybank/models/data/type/type.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// for managing CustomerCard inputs, add,hide inputs, identify inputs
final customerAccountAddedInputsProvider = StateProvider<Map<int, bool>>((ref) {
  return {};
});

// store selected items so as to reduce items for the remain dropdowns
final customerAccountOwnerSelectedCardsTypesProvider =
    StateProvider<Map<String, Type>>(
  (ref) {
    return {};
  },
);

final customerAccountOwnerCardLabelProvider = StateProvider.family<String, int>(
  (ref, customerCardIndex) {
    return '';
  },
);

class CustomerAccountValidators {
  static String? customerAccountOwnerCardLabel(
    String? value,
    int productIndex,
    WidgetRef ref,
  ) {
    if (ref.watch(customerAccountOwnerCardLabelProvider(productIndex)) == '') {
      return 'Entrez le libellé de la carte';
    } else if (ref
            .watch(customerAccountOwnerCardLabelProvider(productIndex))
            .length <
        6) {
      return 'Le libellé doit comporter au moins 6 lettres';
    }
    return null;
  }
}
