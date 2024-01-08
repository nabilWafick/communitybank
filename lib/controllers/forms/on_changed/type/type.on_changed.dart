import 'package:communitybank/controllers/forms/on_changed/common/common.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/type/type.validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TypeOnChanged {
  static typeName(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        typeNameProvider,
      );

  static typeStake(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onDoubleTextInputValueChanged(
        value,
        ref,
        typeStakeProvider,
      );

  static typeProductNumber(String? value, int productIndex, WidgetRef ref) =>
      CommonOnChangedFunction.onIntTextInputValueChanged(
        value,
        ref,
        typeProductNumberProvider(productIndex),
      );
}
