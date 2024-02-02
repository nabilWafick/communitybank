import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/views/widgets/definitions/customers/customers_list/customers_list.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final formCustomerAccountDropdownProvider =
    StateProvider.family<CustomerAccount, String>((ref, dropdown) {
  return CustomerAccount(
    customerId: 0,
    collectorId: 0,
    customerCardsIds: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

class CBFormCustomerAccountDropdown extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<CustomerAccount> dropdownMenuEntriesLabels;
  final List<CustomerAccount> dropdownMenuEntriesValues;
  final double? width;
  final double? menuHeigth;

  const CBFormCustomerAccountDropdown({
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
      _CBFormCustomerAccountDropdownState();
}

class _CBFormCustomerAccountDropdownState
    extends ConsumerState<CBFormCustomerAccountDropdown> {
  @override
  void initState() {
    Future.delayed(
        const Duration(
          milliseconds: 100,
        ), () {
// check if dropdown item is not empty so as to avoid error while setting the  the first item as the selectedItem
      if (widget.dropdownMenuEntriesValues.isNotEmpty) {
        ref
            .read(formCustomerAccountDropdownProvider(widget.providerName)
                .notifier)
            .state = widget.dropdownMenuEntriesValues[0];
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem =
        ref.watch(formCustomerAccountDropdownProvider(widget.providerName));
    final customersListStream = ref.watch(customersListStreamProvider);
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
                label: customersListStream.when(
                  data: (data) {
                    final customer = data.firstWhere((customer) =>
                        customer.id == dropdownMenuEntryLabel.customerId);
                    return '${customer.firstnames} ${customer.name}';
                  },
                  error: (error, stackTrace) => '',
                  loading: () => '',
                ),
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
              .read(formCustomerAccountDropdownProvider(widget.providerName)
                  .notifier)
              .state = value!;
        },
      ),
    );
  }
}
