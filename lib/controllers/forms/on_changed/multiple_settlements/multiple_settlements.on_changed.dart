import 'package:communitybank/controllers/forms/on_changed/common/common.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/multiple_settlements/multiple_settlements.validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MultipleSttlementsOnChanged {
  static multipleSettlementsSettlementNumber(
    String? value,
    int settlementIndex,
    WidgetRef ref,
  ) =>
      CommonOnChangedFunction.onIntTextInputValueChanged(
        value,
        ref,
        multipleSettlementsSettlementNumberProvider(settlementIndex),
      );
}
