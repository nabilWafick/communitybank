import 'package:communitybank/models/data/economical_activity/economical_activity.model.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final formEconomicalActivityDropdownProvider =
    StateProvider.family<EconomicalActivity, String>((ref, dropdown) {
  return EconomicalActivity(
    name: 'Non définie',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

class CBFormEconomicalActivityDropdown extends StatefulHookConsumerWidget {
  final String label;
  final String providerName;
  final List<EconomicalActivity> dropdownMenuEntriesLabels;
  final List<EconomicalActivity> dropdownMenuEntriesValues;
  final double? width;

  const CBFormEconomicalActivityDropdown({
    super.key,
    this.width,
    required this.label,
    required this.providerName,
    required this.dropdownMenuEntriesLabels,
    required this.dropdownMenuEntriesValues,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CBFormEconomicalActivityDropdownState();
}

class _CBFormEconomicalActivityDropdownState
    extends ConsumerState<CBFormEconomicalActivityDropdown> {
  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem =
        ref.watch(formEconomicalActivityDropdownProvider(widget.providerName));

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
              .read(formEconomicalActivityDropdownProvider(widget.providerName)
                  .notifier)
              .state = value!;
        },
      ),
    );
  }
}
