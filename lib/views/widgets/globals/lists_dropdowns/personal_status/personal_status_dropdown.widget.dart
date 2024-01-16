import 'package:communitybank/models/data/personal_status/personal_status.model.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listPersonalStatusDropdownProvider =
    StateProvider.family<PersonalStatus, String>((ref, dropdown) {
  return PersonalStatus(
    id: 0,
    name: 'Tous',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

class CBListPersonalStatusDropdown extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<PersonalStatus> dropdownMenuEntriesLabels;
  final List<PersonalStatus> dropdownMenuEntriesValues;
  final double? width;

  const CBListPersonalStatusDropdown({
    super.key,
    this.width,
    required this.label,
    required this.providerName,
    required this.dropdownMenuEntriesLabels,
    required this.dropdownMenuEntriesValues,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CBListPersonalStatusDropdownState();
}

class _CBListPersonalStatusDropdownState
    extends ConsumerState<CBListPersonalStatusDropdown> {
  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem =
        ref.watch(listPersonalStatusDropdownProvider(widget.providerName));

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
              .read(listPersonalStatusDropdownProvider(widget.providerName)
                  .notifier)
              .state = value!;
        },
      ),
    );
  }
}
