import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final formCollectorDropdownProvider =
    StateProvider.family<Collector, String>((ref, dropdown) {
  return Collector(
    name: '',
    firstnames: '',
    phoneNumber: '',
    address: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

class CBFormCollectorDropdown extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<Collector> dropdownMenuEntriesLabels;
  final List<Collector> dropdownMenuEntriesValues;
  final double? width;

  const CBFormCollectorDropdown({
    super.key,
    this.width,
    required this.label,
    required this.providerName,
    required this.dropdownMenuEntriesLabels,
    required this.dropdownMenuEntriesValues,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CBFormCollectorDropdownState();
}

class _CBFormCollectorDropdownState
    extends ConsumerState<CBFormCollectorDropdown> {
  @override
  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem =
        ref.watch(formCollectorDropdownProvider(widget.providerName));

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
              .read(formCollectorDropdownProvider(widget.providerName).notifier)
              .state = value!;
        },
      ),
    );
  }
}
