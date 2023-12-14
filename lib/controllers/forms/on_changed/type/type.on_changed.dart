import 'package:communitybank/controllers/forms/on_changed/common/common.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/type/type.validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CBTypeOnChanged {
  static typeName(String? value, WidgetRef ref) =>
      CBCommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        typeNameProvider,
      );

  static typeStake(String? value, WidgetRef ref) =>
      CBCommonOnChangedFunction.onDoubleTextInputValueChanged(
        value,
        ref,
        typeStakeProvider,
      );
}
