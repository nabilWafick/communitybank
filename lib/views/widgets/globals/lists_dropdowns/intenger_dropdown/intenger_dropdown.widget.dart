import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listIntDropdownProvider =
    StateProvider.family<int, String>((ref, dropdown) {
  return 100000;
});

class CBListIntDropdown extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<String> dropdownMenuEntriesLabels;
  final List<int> dropdownMenuEntriesValues;
  final double? width;
  final double? menuHeigth;

  const CBListIntDropdown({
    super.key,
    this.width,
    this.menuHeigth,
    required this.label,
    required this.providerName,
    required this.dropdownMenuEntriesLabels,
    required this.dropdownMenuEntriesValues,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CBListIntDropdownState();
}

class _CBListIntDropdownState extends ConsumerState<CBListIntDropdown> {
  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem =
        ref.watch(listIntDropdownProvider(widget.providerName));
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      child: DropdownMenu(
        width: widget.width,
        menuHeight: widget.menuHeigth,
        enableFilter: true,
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
          ref
              .read(listIntDropdownProvider(widget.providerName).notifier)
              .state = value!;
        },
      ),
    );
  }
}
