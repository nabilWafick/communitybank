import 'package:communitybank/controllers/forms/on_changed/common/common.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/locality/locality.validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalityOnChanged {
  static localityName(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        localityNameProvider,
      );
}
