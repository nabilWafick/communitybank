import 'package:communitybank/models/data/agent/agent.model.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listAgentDropdownProvider =
    StateProvider.family<Agent, String>((ref, dropdown) {
  return Agent(
    id: 0,
    name: 'Tous',
    firstnames: '',
    phoneNumber: '',
    email: '',
    role: '',
    address: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

class CBListAgentDropdown extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<Agent> dropdownMenuEntriesLabels;
  final List<Agent> dropdownMenuEntriesValues;
  final double? width;
  final double? menuHeigth;

  const CBListAgentDropdown({
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
      _CBListAgentDropdownState();
}

class _CBListAgentDropdownState extends ConsumerState<CBListAgentDropdown> {
  @override
  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem =
        ref.watch(listAgentDropdownProvider(widget.providerName));

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
                label:
                    '${dropdownMenuEntryLabel.name} ${dropdownMenuEntryLabel.firstnames}',
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
              .read(listAgentDropdownProvider(widget.providerName).notifier)
              .state = value!;
        },
      ),
    );
  }
}
