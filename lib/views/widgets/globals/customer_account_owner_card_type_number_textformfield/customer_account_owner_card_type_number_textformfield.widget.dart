import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
//import 'package:yaru_icons/yaru_icons.dart';

class CBCustomerAccountOwnerCardTypeNumberTextFormField
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

  const CBCustomerAccountOwnerCardTypeNumberTextFormField({
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
    final showPassword = useState<bool>(false);
    return TextFormField(
      controller: textEditingController,
      initialValue: initialValue,
      keyboardType: textInputType,
      cursorColor: CBColors.primaryColor,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.5, vertical: 16.5),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(.0),
          borderSide:
              const BorderSide(color: CBColors.tertiaryColor, width: .5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(.0),
          borderSide:
              const BorderSide(color: CBColors.primaryColor, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(.0),
          borderSide: const BorderSide(color: Colors.red, width: .5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(.0),
          borderSide: const BorderSide(color: Colors.red, width: .5),
        ),
        label: label != null
            ? CBText(
                text: label!,
                // fontSize: 15.0,
              )
            : null,
        hintText: hintText,
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: () {
                  showPassword.value = !showPassword.value;
                },
                icon: Icon(
                  showPassword.value ? Icons.visibility : suffixIcon,
                ),
              )
            : null,
      ),
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
