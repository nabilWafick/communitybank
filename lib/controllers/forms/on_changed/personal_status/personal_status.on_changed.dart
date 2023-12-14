import 'package:communitybank/controllers/forms/on_changed/common/common.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/product/product.validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CBPersonalStatusOnChanged {
  static personalStatusName(String? value, WidgetRef ref) =>
      CBCommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        productNameProvider,
      );
}
