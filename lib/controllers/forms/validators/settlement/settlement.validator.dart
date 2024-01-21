import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settlementNumberProvider = StateProvider<int>(
  (ref) {
    return 0;
  },
);

final settlementCustomerCardProvider = StateProvider<CustomerCard>((ref) {
  return CustomerCard(
    label: 'Non définie',
    typeId: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

// final settlementAgentProvider = StateProvider<Agent>((ref) {
//   return Agent(
//     name: 'USER',
//     firstnames: 'User',
//     phoneNumber: '',
//     address: '',
//     role: '',
//     createdAt: DateTime.now(),
//     updatedAt: DateTime.now(),
//   );
// });

final settlementCollectionDateProvider = StateProvider<DateTime?>(
  (ref) {
    return;
  },
);

class SettlementValidors {
  static String? settlementNumber(String? value, WidgetRef ref) {
    final settlementNumber = ref.watch(settlementNumberProvider);
    if (settlementNumber <= 0 || settlementNumber > 372) {
      return 'Entrez un nombre valide';
    }
    return null;
  }
}
