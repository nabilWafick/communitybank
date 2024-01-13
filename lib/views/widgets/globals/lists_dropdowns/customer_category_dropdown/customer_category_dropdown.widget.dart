import 'package:communitybank/models/data/customers_category/customers_category.model.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listCustomerCategoryDropdownProvider =
    StateProvider.family<CustomerCategory, String>((ref, dropdown) {
  return CustomerCategory(
    id: 0,
    name: 'Toutes',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

class CBListCustomerCategoryDropdown extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<CustomerCategory> dropdownMenuEntriesLabels;
  final List<CustomerCategory> dropdownMenuEntriesValues;
  final double? width;

  const CBListCustomerCategoryDropdown({
    super.key,
    this.width,
    required this.label,
    required this.providerName,
    required this.dropdownMenuEntriesLabels,
    required this.dropdownMenuEntriesValues,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CBListCustomerCategoryDropdownState();
}

class _CBListCustomerCategoryDropdownState
    extends ConsumerState<CBListCustomerCategoryDropdown> {
  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem =
        ref.watch(listCustomerCategoryDropdownProvider(widget.providerName));

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
              .read(listCustomerCategoryDropdownProvider(widget.providerName)
                  .notifier)
              .state = value!;
          //   debugPrint('new category: $value');
        },
      ),
    );
  }
}
