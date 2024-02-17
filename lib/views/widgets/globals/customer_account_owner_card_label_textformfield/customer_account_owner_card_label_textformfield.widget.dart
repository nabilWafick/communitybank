import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
//import 'package:yaru_icons/yaru_icons.dart';

class CBCustomerAccountOwnerCardLabelTextFormField extends HookConsumerWidget {
  final int inputIndex;
  final TextEditingController? textEditingController;
  final String? label;
  final String? hintText;
  final String? initialValue;
  final IconData? suffixIcon;
  final TextInputType textInputType;
  final String? Function(String?, int, WidgetRef) validator;
  final void Function(String?, int, WidgetRef) onChanged;

  const CBCustomerAccountOwnerCardLabelTextFormField({
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
      style: const TextStyle(
        fontSize: 12.0,
      ),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.5, vertical: 16.5),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            topRight: Radius.circular(.0),
            bottomRight: Radius.circular(.0),
          ),
          borderSide: BorderSide(color: CBColors.tertiaryColor, width: .5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            topRight: Radius.circular(.0),
            bottomRight: Radius.circular(.0),
          ),
          borderSide: BorderSide(color: CBColors.primaryColor, width: 2.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            topRight: Radius.circular(.0),
            bottomRight: Radius.circular(.0),
          ),
          borderSide: BorderSide(color: Colors.red, width: .5),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            topRight: Radius.circular(.0),
            bottomRight: Radius.circular(.0),
          ),
          borderSide: BorderSide(color: Colors.red, width: .5),
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
