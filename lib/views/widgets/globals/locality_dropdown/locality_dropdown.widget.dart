import 'package:communitybank/models/data/locality/locality.model.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dropdownSelectedItemProvider =
    StateProvider.family<Locality, String>((ref, dropdown) {
  return Locality(
    name: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

class CBSortDropdownLocality extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<Locality> dropdownMenuEntriesLabels;
  final List<Locality> dropdownMenuEntriesValues;
  final double? width;

  const CBSortDropdownLocality({
    super.key,
    this.width,
    required this.label,
    required this.providerName,
    required this.dropdownMenuEntriesLabels,
    required this.dropdownMenuEntriesValues,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CBSortDropdownLocalityState();
}

class _CBSortDropdownLocalityState
    extends ConsumerState<CBSortDropdownLocality> {
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
            .read(dropdownSelectedItemProvider(widget.providerName).notifier)
            .state = widget.dropdownMenuEntriesValues[0];
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem =
        ref.watch(dropdownSelectedItemProvider(widget.providerName));
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
              .read(dropdownSelectedItemProvider(widget.providerName).notifier)
              .state = value!;
        },
      ),
    );
  }
}
