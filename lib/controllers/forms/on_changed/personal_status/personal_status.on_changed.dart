import 'package:communitybank/controllers/forms/on_changed/common/common.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/personal_status/personal_status.validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonalStatusOnChanged {
  static personalStatusName(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        personalStatusNameProvider,
      );
}
