import 'package:communitybank/controllers/forms/on_changed/common/common.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/customer_account/customer_account.validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerAccountOnChanged {
  static customerAccountOwnerCardLabel(
          String? value, int customerCardIndex, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        customerAccountOwnerCardLabelProvider(customerCardIndex),
      );

  static customerAccountOwnerCardTypeNumber(
          String? value, int customerCardIndex, WidgetRef ref) =>
      CommonOnChangedFunction.onIntTextInputValueChanged(
        value,
        ref,
        customerAccountOwnerCardTypeNumberProvider(customerCardIndex),
      );
}
