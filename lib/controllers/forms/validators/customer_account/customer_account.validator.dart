import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// for managing CustomerCard inputs, add,hide inputs, identify inputs
final customerAccountAddedInputsProvider = StateProvider<Map<int, bool>>((ref) {
  return {};
});

// store selected items so as to reduce items for the remain dropdowns
final customerAccountSelectedOwnerCardsProvider =
    StateProvider<Map<String, CustomerCard>>(
  (ref) {
    return {};
  },
);
