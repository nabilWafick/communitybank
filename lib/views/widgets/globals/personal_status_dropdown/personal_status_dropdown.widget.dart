import 'package:communitybank/models/data/personal_status/personal_status.model.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final personalStatusDropdownProvider =
    StateProvider.family<PersonalStatus, String>((ref, dropdown) {
  return PersonalStatus(
    name: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

class CBPersonalStatusDropdown extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<PersonalStatus> dropdownMenuEntriesLabels;
  final List<PersonalStatus> dropdownMenuEntriesValues;
  final double? width;

  const CBPersonalStatusDropdown({
    super.key,
    this.width,
    required this.label,
    required this.providerName,
    required this.dropdownMenuEntriesLabels,
    required this.dropdownMenuEntriesValues,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CBPersonalStatusDropdownState();
}

class _CBPersonalStatusDropdownState
    extends ConsumerState<CBPersonalStatusDropdown> {
  @override
  void initState() {
    // future used for avoiding error due to ref.read in initState function
    Future.delayed(
        const Duration(
          milliseconds: 1,
        ), () {
// check if dropdown item is not empty so as to avoid error while setting the  the first item as the selectedItem
      if (widget.dropdownMenuEntriesValues.isNotEmpty) {
        ref
            .read(personalStatusDropdownProvider(widget.providerName).notifier)
            .state = widget.dropdownMenuEntriesValues[0];
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem =
        ref.watch(personalStatusDropdownProvider(widget.providerName));
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
              .read(
                  personalStatusDropdownProvider(widget.providerName).notifier)
              .state = value!;
        },
      ),
    );
  }
}
