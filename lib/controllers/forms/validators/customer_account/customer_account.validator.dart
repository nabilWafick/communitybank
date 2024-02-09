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

final customerAccountOwnerCardTypeNumberProvider =
    StateProvider.family<int, int>(
  (ref, customerCardIndex) {
    return 1;
  },
);

class CustomerAccountValidators {
  static String? customerAccountOwnerCardLabel(
    String? value,
    int cardIndex,
    WidgetRef ref,
  ) {
    if (ref.watch(customerAccountOwnerCardLabelProvider(cardIndex)) == '') {
      return 'Entrez le libellé de la carte';
    } else if (ref
            .watch(customerAccountOwnerCardLabelProvider(cardIndex))
            .length <
        6) {
      return 'Le libellé doit comporter au moins 6 lettres';
    }
    return null;
  }

  static String? customerAccountOwnerCardTypeNumber(
    String? value,
    int cardIndex,
    WidgetRef ref,
  ) {
    if (ref.watch(customerAccountOwnerCardTypeNumberProvider(cardIndex)) == 0) {
      return 'Entrez un nombre valide';
    }
    return null;
  }
}
