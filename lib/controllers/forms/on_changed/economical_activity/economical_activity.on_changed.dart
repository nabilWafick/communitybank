import 'package:communitybank/controllers/forms/on_changed/common/common.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/economical_activity/economical_activity.validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CBEconomicalActivityOnChanged {
  static economicalActivityName(String? value, WidgetRef ref) =>
      CBCommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        economicalActivityNameProvider,
      );
}
