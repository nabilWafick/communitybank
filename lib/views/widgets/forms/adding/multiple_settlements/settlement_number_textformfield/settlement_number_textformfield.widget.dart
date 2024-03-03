import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:communitybank/utils/colors/colors.util.dart';

class CBMultipleSettementsSettlementNumberTextFormField
    extends HookConsumerWidget {
  final int inputIndex;
  final TextEditingController? textEditingController;
  final String? label;
  final String? hintText;
  final String? initialValue;
  final IconData? suffixIcon;
  final TextInputType textInputType;
  final String? Function(String?, int, WidgetRef) validator;
  final void Function(String?, int, WidgetRef) onChanged;

  const CBMultipleSettementsSettlementNumberTextFormField({
    super.key,
    required this.inputIndex,
    this.textEditingController,
    this.label,
    this.hintText,
    this.initialValue,
    this.suffixIcon,
    required this.textInputType,
    required this.validator,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final showPassword = useState<bool>(false);
    return TextFormField(
      controller: textEditingController,
      initialValue: initialValue,
      keyboardType: textInputType,
      cursorColor: CBColors.primaryColor,
      validator: (value) {
        return validator(value, inputIndex, ref);
      },
      onChanged: (newValue) {
        onChanged(newValue, inputIndex, ref);
      },
      onSaved: (newValue) {
        onChanged(newValue, inputIndex, ref);
      },
      enableSuggestions: true,
    );
  }
}
