import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:communitybank/models/data/type/type.model.dart';

final formCustomerCardDropdownProvider =
    StateProvider.family<CustomerCard, String>((ref, dropdown) {
  return CustomerCard(
    label: 'Non défini',
    typeId: 0,
    type: Type(
      name: 'Undefined',
      stake: 0,
      products: [],
      createdAt: DateTime(700),
      updatedAt: DateTime(700),
    ),
    satisfiedAt: DateTime.now(), // nullable value
    repaidAt: DateTime.now(), // nullable value
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

class CBFormCustomerCardDropdown extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<CustomerCard> dropdownMenuEntriesLabels;
  final List<CustomerCard> dropdownMenuEntriesValues;
  final double? width;

  const CBFormCustomerCardDropdown({
    super.key,
    this.width,
    required this.label,
    required this.providerName,
    required this.dropdownMenuEntriesLabels,
    required this.dropdownMenuEntriesValues,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CBFormCustomerCardDropdownState();
}

class _CBFormCustomerCardDropdownState
    extends ConsumerState<CBFormCustomerCardDropdown> {
  @override
  void initState() {
    Future.delayed(
        const Duration(
          milliseconds: 100,
        ), () {
// check if dropdown item is not empty so as to avoid error while setting the  the first item as the selectedItem
      if (widget.dropdownMenuEntriesValues.isNotEmpty) {
        ref
            .read(
                formCustomerCardDropdownProvider(widget.providerName).notifier)
            .state = widget.dropdownMenuEntriesValues[0];
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem =
        ref.watch(formCustomerCardDropdownProvider(widget.providerName));
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
              .read(formCustomerCardDropdownProvider(widget.providerName)
                  .notifier)
              .state = value!;
        },
      ),
    );
  }
}
