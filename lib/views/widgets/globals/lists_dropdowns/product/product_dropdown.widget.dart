import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listProductDropdownProvider =
    StateProvider.family<Product, String>((ref, dropdown) {
  return Product(
    id: 0,
    name: 'Tous',
    purchasePrice: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

class CBListProductDropdown extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<Product> dropdownMenuEntriesLabels;
  final List<Product> dropdownMenuEntriesValues;
  final double? width;
  final double? menuHeigth;

  const CBListProductDropdown({
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
      _CBListProductDropdownState();
}

class _CBListProductDropdownState extends ConsumerState<CBListProductDropdown> {
  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem =
        ref.watch(listProductDropdownProvider(widget.providerName));

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
              .read(listProductDropdownProvider(widget.providerName).notifier)
              .state = value!;
        },
      ),
    );
  }
}
