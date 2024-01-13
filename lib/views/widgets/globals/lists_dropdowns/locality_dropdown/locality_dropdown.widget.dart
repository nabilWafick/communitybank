import 'package:communitybank/models/data/locality/locality.model.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listLocalityDropdownProvider =
    StateProvider.family<Locality, String>((ref, dropdown) {
  return Locality(
    id: 0,
    name: 'Toutes',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

class CBListLocalityDropdown extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<Locality> dropdownMenuEntriesLabels;
  final List<Locality> dropdownMenuEntriesValues;
  final double? width;

  const CBListLocalityDropdown({
    super.key,
    this.width,
    required this.label,
    required this.providerName,
    required this.dropdownMenuEntriesLabels,
    required this.dropdownMenuEntriesValues,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CBListLocalityDropdownState();
}

class _CBListLocalityDropdownState
    extends ConsumerState<CBListLocalityDropdown> {
  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem =
        ref.watch(listLocalityDropdownProvider(widget.providerName));

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
              .read(listLocalityDropdownProvider(widget.providerName).notifier)
              .state = value!;
        },
      ),
    );
  }
}
