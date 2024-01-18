import 'package:communitybank/controllers/forms/on_changed/common/common.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/customer_card/customer_card.validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerCardOnChanged {
  static customerCardLabel(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        customerCardLabelProvider,
      );
}
