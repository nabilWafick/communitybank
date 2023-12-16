import 'package:communitybank/controllers/forms/on_changed/common/common.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/economical_activity/economical_activity.validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EconomicalActivityOnChanged {
  static economicalActivityName(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        economicalActivityNameProvider,
      );
}
