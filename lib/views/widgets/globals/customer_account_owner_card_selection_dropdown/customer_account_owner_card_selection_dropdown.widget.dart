import 'package:communitybank/controllers/forms/validators/customer_account/customer_account.validator.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final customerAccountOwnerCardSelectionDropdownProvider =
    StateProvider.family<CustomerCard, String>((ref, dropdown) {
  return CustomerCard(
    label: '',
    typeId: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

class CBCustomerAccountOwnerCardSelectionDropdown
    extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<CustomerCard> dropdownMenuEntriesLabels;
  final List<CustomerCard> dropdownMenuEntriesValues;
  final double? width;

  const CBCustomerAccountOwnerCardSelectionDropdown({
    super.key,
    this.width,
    required this.label,
    required this.providerName,
    required this.dropdownMenuEntriesLabels,
    required this.dropdownMenuEntriesValues,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CBCustomerAccountOwnerCardSelectionDropdownState();
}

class _CBCustomerAccountOwnerCardSelectionDropdownState
    extends ConsumerState<CBCustomerAccountOwnerCardSelectionDropdown> {
  @override
  void initState() {
    Future.delayed(
        const Duration(
          milliseconds: 100,
        ), () {
// check if dropdown item is not empty so as to avoid error while setting the  the first item as the selectedItem
      if (widget.dropdownMenuEntriesValues.isNotEmpty) {
        ref
            .read(customerAccountOwnerCardSelectionDropdownProvider(
                    widget.providerName)
                .notifier)
            .state = widget.dropdownMenuEntriesValues[0];

// put the selected item in the selectedProduct map so as to reduce items for the remain dropdowns
        ref
            .read(customerAccountSelectedOwnerCardsProvider.notifier)
            .update((state) {
          state[widget.providerName] = widget.dropdownMenuEntriesValues[0];
          return state;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem = ref.watch(
        customerAccountOwnerCardSelectionDropdownProvider(widget.providerName));
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
              .read(customerAccountSelectedOwnerCardsProvider.notifier)
              .update((state) {
            state[widget.providerName] = value!;
            return state;
          });
          ref
              .read(customerAccountOwnerCardSelectionDropdownProvider(
                      widget.providerName)
                  .notifier)
              .state = value!;

          ref
              .read(customerAccountSelectedOwnerCardsProvider.notifier)
              .update((state) {
            state[widget.providerName] = value;
            return state;
          });
        },
      ),
    );
  }
}
