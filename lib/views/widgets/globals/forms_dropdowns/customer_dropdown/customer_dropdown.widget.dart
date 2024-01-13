import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/models/data/customers_category/customers_category.model.dart';
import 'package:communitybank/models/data/economical_activity/economical_activity.model.dart';
import 'package:communitybank/models/data/locality/locality.model.dart';
import 'package:communitybank/models/data/personal_status/personal_status.model.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final formCustomerDropdownProvider =
    StateProvider.family<Customer, String>((ref, dropdown) {
  return Customer(
    name: 'Non défini',
    firstnames: '',
    phoneNumber: '',
    address: '',
    profession: '',
    nicNumber: 1,
    category: CustomerCategory(
      name: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    economicalActivity: EconomicalActivity(
      name: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    personalStatus: PersonalStatus(
      name: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    locality: Locality(
      name: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

class CBFormCustomerDropdown extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<Customer> dropdownMenuEntriesLabels;
  final List<Customer> dropdownMenuEntriesValues;
  final double? width;

  const CBFormCustomerDropdown({
    super.key,
    this.width,
    required this.label,
    required this.providerName,
    required this.dropdownMenuEntriesLabels,
    required this.dropdownMenuEntriesValues,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CBFormCustomerDropdownState();
}

class _CBFormCustomerDropdownState
    extends ConsumerState<CBFormCustomerDropdown> {
  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem =
        ref.watch(formCustomerDropdownProvider(widget.providerName));
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
              .read(formCustomerDropdownProvider(widget.providerName).notifier)
              .state = value!;
        },
      ),
    );
  }
}
