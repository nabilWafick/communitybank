import 'package:communitybank/controllers/forms/on_changed/common/common.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/collector/collector.validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerCardOnChanged {
  static customerCardLabel(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        collectorNameProvider,
      );
}
