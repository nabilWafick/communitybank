import 'package:communitybank/controllers/forms/on_changed/common/common.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/settlement/settlement.validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettlementOnChanged {
  static settlementName(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onIntTextInputValueChanged(
        value,
        ref,
        settlementNumberProvider,
      );
}
