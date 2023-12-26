import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CBProductSelectionDropdown extends CBDropdown {
  final double? width;
  const CBProductSelectionDropdown({
    super.key,
    required super.label,
    required super.providerName,
    required super.dropdownMenuEntriesLabels,
    required super.dropdownMenuEntriesValues,
    this.width,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDropdownItem =
        ref.watch(selectedDropdownItemProvider(providerName));
    return DropdownMenu(
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            topRight: Radius.circular(.0),
            bottomRight: Radius.circular(.0),
          ),
          borderSide: BorderSide(color: CBColors.tertiaryColor, width: .5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            topRight: Radius.circular(.0),
            bottomRight: Radius.circular(.0),
          ),
          borderSide: BorderSide(color: CBColors.primaryColor, width: 2.0),
        ),
      ),
      width: width,
      label: CBText(
        text: label,
      ),
      hintText: label,
      initialSelection: selectedDropdownItem,
      dropdownMenuEntries: dropdownMenuEntriesLabels
          .map(
            (dropdownMenuEntryLabel) => DropdownMenuEntry(
              value: dropdownMenuEntriesValues[
                  dropdownMenuEntriesLabels.indexOf(dropdownMenuEntryLabel)],
              label: dropdownMenuEntryLabel,
              style: const ButtonStyle(
                textStyle: MaterialStatePropertyAll(
                  TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
          .toList(),
      trailingIcon: const Icon(Icons.arrow_drop_down),
      onSelected: (value) {
        ref.read(selectedDropdownItemProvider(providerName).notifier).state =
            value!;
      },
    );
  }
}
