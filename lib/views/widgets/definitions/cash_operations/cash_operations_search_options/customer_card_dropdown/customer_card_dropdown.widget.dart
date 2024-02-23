import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/views/widgets/definitions/cash_operations/cash_operations_search_options/cash_operations_search_options.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cashOperationsSearchOptionsCustomerCardDropdownProvider =
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
  final double? menuHeigth;

  const CBCashOperationsSearchOptionsCustumerCardDropdown({
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
      _CBCashOperationsSearchOptionsCustumerCardDropdownState();
}

class _CBCashOperationsSearchOptionsCustumerCardDropdownState
    extends ConsumerState<CBCashOperationsSearchOptionsCustumerCardDropdown> {
  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem = ref.watch(
      cashOperationsSearchOptionsCustomerCardDropdownProvider(
          widget.providerName),
    );
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
          ref.read(isRefreshingProvider.notifier).state = false;
          ref
              .read(cashOperationsSearchOptionsCustomerCardDropdownProvider(
                widget.providerName,
              ).notifier)
              .state = value!;
          ref
              .read(
                cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider
                    .notifier,
              )
              .state = value;
        },
      ),
    );
  }
}
