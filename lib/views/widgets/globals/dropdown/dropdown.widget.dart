import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDropdownItemProvider =
    StateProvider.family<String, String>((ref, dropdown) {
  return dropdown;
});

class CBDropdown extends ConsumerWidget {
  final String label;
  final List<String> dropdownMenuEntriesLabels;
  final List<String> dropdownMenuEntriesValues;

  const CBDropdown({
    super.key,
    required this.label,
    required this.dropdownMenuEntriesLabels,
    required this.dropdownMenuEntriesValues,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDropdownItem = ref.watch(selectedDropdownItemProvider(label));
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      child: DropdownMenu(
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
          ref.read(selectedDropdownItemProvider(label).notifier).state = value!;
        },
      ),
    );
  }
}
