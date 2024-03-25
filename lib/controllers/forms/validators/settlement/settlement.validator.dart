import 'package:flutter_riverpod/flutter_riverpod.dart';

final settlementNumberProvider = StateProvider<int>(
  (ref) {
    return 0;
  },
);

final settlementCollectionDateProvider = StateProvider<DateTime?>(
  (ref) {
    return;
  },
);

class SettlementValidators {
  static String? settlementNumber(String? value, WidgetRef ref) {
    final settlementNumber = ref.watch(settlementNumberProvider);
    if (settlementNumber <= 0 || settlementNumber > 372) {
      return 'Entrez un nombre valide';
    }
    return null;
  }
}
