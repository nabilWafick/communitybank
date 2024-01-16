import 'package:communitybank/controllers/forms/on_changed/common/common.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/agent/agent.validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AgentOnChanged {
  static agentName(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        agentNameProvider,
      );

  static agentFirstnames(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        agentFirstnamesProvider,
      );

  static agentPhoneNumber(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        agentPhoneNumberProvider,
      );

  static agentAddress(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        agentAddressProvider,
      );
}
