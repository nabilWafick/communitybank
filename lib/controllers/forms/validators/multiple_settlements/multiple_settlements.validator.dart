import 'package:communitybank/models/data/type/type.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// for managing Types inputs, add,hide inputs, identify inputs
final multipleSettlementsAddedInputsProvider =
    StateProvider<Map<int, bool>>((ref) {
  return {};
});

// store selected items so as to reduce items for the remain dropdowns
final multipleSettlementsSelectedTypesProvider =
    StateProvider<Map<String, Type>>(
  (ref) {
    return {};
  },
);

final multipleSettlementsSettlementNumberProvider =
    StateProvider.family<int, int>(
  (ref, settlementIndex) {
    return 0;
  },
);

class MultipleSettlementsValidators {
  static String? multipleSettlementsSettlementNumber(
    String? value,
    int settlementIndex,
    WidgetRef ref,
  ) {
    if (ref.watch(
            multipleSettlementsSettlementNumberProvider(settlementIndex)) ==
        0) {
      return 'Entrez une valeur';
    }
    return null;
  }
}
