import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stringDropdownProvider =
    StateProvider.family<String, String>((ref, dropdown) {
  return '*';
});

class CBStringDropdown extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<String> dropdownMenuEntriesLabels;
  final List<String> dropdownMenuEntriesValues;
  final double? width;

  const CBStringDropdown({
    super.key,
    this.width,
    required this.label,
    required this.providerName,
    required this.dropdownMenuEntriesLabels,
    required this.dropdownMenuEntriesValues,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CBStringDropdownState();
}

class _CBStringDropdownState extends ConsumerState<CBStringDropdown> {
  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem =
        ref.watch(stringDropdownProvider(widget.providerName));
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      child: DropdownMenu(
        width: widget.width,
        label: CBText(
          text: widget.label,
        ),
        hintText: widget.label,
        initialSelection: selectedDropdownItem,
        dropdownMenuEntries: widget.dropdownMenuEntriesLabels
            .map(
              (dropdownMenuEntryLabel) => DropdownMenuEntry(
                value: widget.dropdownMenuEntriesValues[widget
                    .dropdownMenuEntriesLabels
                    .indexOf(dropdownMenuEntryLabel)],
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
        trailingIcon: const Icon(
          Icons.arrow_drop_down,
        ),
        onSelected: (value) {
          ref.read(stringDropdownProvider(widget.providerName).notifier).state =
              value!;
        },
      ),
    );
  }
}
