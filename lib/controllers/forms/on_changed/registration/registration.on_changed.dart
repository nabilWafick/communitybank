import 'package:communitybank/controllers/forms/on_changed/common/common.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/registration/registration.validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationOnChanged {
  static newUserEmail(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        newUserEmailProvider,
      );

  static newUserPassword(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        newUserPasswordProvider,
      );
}
