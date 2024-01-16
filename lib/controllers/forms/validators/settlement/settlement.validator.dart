import 'package:flutter_riverpod/flutter_riverpod.dart';

final settlementNumberProvider = StateProvider<int>(
  (ref) {
    return 0;
  },
);

final settlementDateProvider = StateProvider<DateTime>(
  (ref) {
    return DateTime.now();
  },
);

class SettlementValidors {
  static String? settlementNumber(String? value, WidgetRef ref) {
    if (ref.watch(settlementNumberProvider) == 0) {
      return 'Entrez un nombre valide';
    }
    return null;
  }
}
