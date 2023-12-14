import 'package:communitybank/controllers/forms/on_changed/common/common.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/customer/customer.validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CBCustomerOnChanged {
  static customerName(String? value, WidgetRef ref) =>
      CBCommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        customerNameProvider,
      );

  static customerFirstnames(String? value, WidgetRef ref) =>
      CBCommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        customerFirstnamesProvider,
      );

  static customerPhoneNumber(String? value, WidgetRef ref) =>
      CBCommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        customerPhoneNumberProvider,
      );

  static customerAddress(String? value, WidgetRef ref) =>
      CBCommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        customerAddressProvider,
      );

  static customerProfession(String? value, WidgetRef ref) =>
      CBCommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        customerProfessionProvider,
      );

  static customerNciNumber(String? value, WidgetRef ref) =>
      CBCommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        customerNciNumberProvider,
      );
}
