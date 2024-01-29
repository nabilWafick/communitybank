import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listTypeDropdownProvider =
    StateProvider.family<Type, String>((ref, dropdown) {
  return Type(
    id: 0,
    name: 'Tous',
    stake: 0,
    productsIds: [],
    productsNumber: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

class CBListTypeDropdown extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<Type> dropdownMenuEntriesLabels;
  final List<Type> dropdownMenuEntriesValues;
  final double? width;

  const CBListTypeDropdown({
    super.key,
    this.width,
    required this.label,
    required this.providerName,
    required this.dropdownMenuEntriesLabels,
    required this.dropdownMenuEntriesValues,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CBListTypeDropdownState();
}

class _CBListTypeDropdownState extends ConsumerState<CBListTypeDropdown> {
  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem =
        ref.watch(listTypeDropdownProvider(widget.providerName));

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
                label: dropdownMenuEntryLabel.name,
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
              .read(listTypeDropdownProvider(widget.providerName).notifier)
              .state = value!;
        },
      ),
    );
  }
}
