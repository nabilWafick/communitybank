import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cashOperationsSearchOptionsCustumerCardDropdownProvider =
    StateProvider.family<CustomerCard?, String>((ref, dropdown) {
  return null;
});

class CBCashOperationsSearchOptionsCustumerCardDropdown
    extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<CustomerCard> dropdownMenuEntriesLabels;
  final List<CustomerCard> dropdownMenuEntriesValues;
  final double? width;

  const CBCashOperationsSearchOptionsCustumerCardDropdown({
    super.key,
    this.width,
    required this.label,
    required this.providerName,
    required this.dropdownMenuEntriesLabels,
    required this.dropdownMenuEntriesValues,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CBCashOperationsSearchOptionsCustumerCardDropdownState();
}

class _CBCashOperationsSearchOptionsCustumerCardDropdownState
    extends ConsumerState<CBCashOperationsSearchOptionsCustumerCardDropdown> {
  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem = ref.watch(
      cashOperationsSearchOptionsCustumerCardDropdownProvider(
          widget.providerName),
    );
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
                label: dropdownMenuEntryLabel.label,
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
              .read(cashOperationsSearchOptionsCustumerCardDropdownProvider(
                      widget.providerName)
                  .notifier)
              .state = value!;
        },
      ),
    );
  }
}
