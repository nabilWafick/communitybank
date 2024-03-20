import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/views/widgets/definitions/customers/customers_list/customers_list.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:communitybank/views/widgets/transferts/between_customers_cards/between_customer_cards_data/between_customer_cards_data.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transfersBetweenCustomerCardsCustomerAccountDropdownProvider =
    StateProvider.family<CustomerAccount?, String>((ref, dropdown) {
  return null;
});

class CBTransfersBetweenCustomerCardsCustomerAccountDropdown
    extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<CustomerAccount> dropdownMenuEntriesLabels;
  final List<CustomerAccount> dropdownMenuEntriesValues;
  final double? width;
  final double? menuHeigth;

  const CBTransfersBetweenCustomerCardsCustomerAccountDropdown({
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
      _CBTransfersBetweenCustomerCardsCustomerAccountDropdownState();
}

class _CBTransfersBetweenCustomerCardsCustomerAccountDropdownState
    extends ConsumerState<
        CBTransfersBetweenCustomerCardsCustomerAccountDropdown> {
  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem = ref.watch(
        transfersBetweenCustomerCardsCustomerAccountDropdownProvider(
            widget.providerName));
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
                    final customer = data.firstWhere(
                      (customer) =>
                          customer.id == dropdownMenuEntryLabel.customerId,
                      orElse: () => Customer(
                        name: '',
                        firstnames: '',
                        phoneNumber: '',
                        address: '',
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
                    );
                    return '${customer.name} ${customer.firstnames}';
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
              .read(
                transfersBetweenCustomerCardsCustomerAccountDropdownProvider(
                  widget.providerName,
                ).notifier,
              )
              .state = value!;

          ref
              .read(
                transfersBetweenCustomerCardsSelectedCustomerAccountProvider
                    .notifier,
              )
              .state = value;
        },
      ),
    );
  }
}
