import 'package:communitybank/controllers/forms/on_changed/common/common.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/collector/collector.validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectorOnChanged {
  static collectorName(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        collectorNameProvider,
      );

  static collectorFirstnames(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        collectorFirstnamesProvider,
      );

  static collectorPhoneNumber(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        collectorPhoneNumberProvider,
      );

  static collectorAddress(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        collectorAddressProvider,
      );
}
