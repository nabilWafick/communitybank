import 'package:communitybank/models/data/type/type.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// for managing Types inputs, add,hide inputs, identify inputs
final multipleSettlementAddedInputsProvider =
    StateProvider<Map<int, bool>>((ref) {
  return {};
});

// store selected items so as to reduce items for the remain dropdowns
final multipleSettlementSelectedTypesProvider =
    StateProvider<Map<String, Type>>(
  (ref) {
    return {};
  },
);

final multipleSettlementTypeNumberProvider = StateProvider.family<int, int>(
  (ref, typeIndex) {
    return 0;
  },
);

class MultipleSettlementValidators {
  static String? multipleSettlementTypeNumber(
      String? value, int typeIndex, WidgetRef ref) {
    if (ref.watch(multipleSettlementTypeNumberProvider(typeIndex)) == 0) {
      return 'Entrez une valeur';
    }
    return null;
  }
}
