import 'package:communitybank/controllers/forms/on_changed/common/common.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/login/login.validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginOnChanged {
  static userEmail(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        userEmailProvider,
      );

  static userPassword(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        userPasswordProvider,
      );
}
