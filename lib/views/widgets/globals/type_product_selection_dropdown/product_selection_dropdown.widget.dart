import 'package:communitybank/controllers/forms/validators/type/type.validator.dart';
import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final typeSelectedProductDropdownProvider =
    StateProvider.family<Product, String>((ref, providerName) {
  return Product(
    name: '',
    purchasePrice: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

class CBTypeProductSelectionDropdown extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<Product> dropdownMenuEntriesLabels;
  final List<Product> dropdownMenuEntriesValues;
  final double? width;

  const CBTypeProductSelectionDropdown({
    super.key,
    this.width,
    required this.label,
    required this.providerName,
    required this.dropdownMenuEntriesLabels,
    required this.dropdownMenuEntriesValues,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CBTypeProductSelectionDropdownState();
}

class _CBTypeProductSelectionDropdownState
    extends ConsumerState<CBTypeProductSelectionDropdown> {
  @override
  Widget build(BuildContext context) {
    final selectedDropdownProduct =
        ref.watch(typeSelectedProductDropdownProvider(widget.providerName));

    Future.delayed(
        const Duration(
          milliseconds: 10,
        ), () {
// check if dropdown item is not empty so as to avoid error while setting the  the first item as the selectedItem
      if (widget.dropdownMenuEntriesValues.isNotEmpty) {
        ref
            .read(typeSelectedProductDropdownProvider(widget.providerName)
                .notifier)
            .state = widget.dropdownMenuEntriesValues[0];
        // put the selected item in the selectedProduct map so as to reduce items for the remain dropdowns
        ref.read(typeSelectedProductsProvider.notifier).update((state) {
          state[widget.providerName] = widget.dropdownMenuEntriesValues[0];
          return state;
        });
      }
    });

    return DropdownMenu(
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            topRight: Radius.circular(.0),
            bottomRight: Radius.circular(.0),
          ),
          borderSide: BorderSide(color: CBColors.tertiaryColor, width: .5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            topRight: Radius.circular(.0),
            bottomRight: Radius.circular(.0),
          ),
          borderSide: BorderSide(color: CBColors.primaryColor, width: 2.0),
        ),
      ),
      width: widget.width,
      label: CBText(
        text: widget.label,
      ),
      hintText: widget.label,
      initialSelection: selectedDropdownProduct,
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
      trailingIcon: const Icon(Icons.arrow_drop_down),
      onSelected: (value) {
        // set the selected product
        ref
            .read(typeSelectedProductDropdownProvider(widget.providerName)
                .notifier)
            .state = value!;
        // put the selected item in the selectedProduct map so as to reduce items for the remain dropdowns
        ref.read(typeSelectedProductsProvider.notifier).update((state) {
          state[widget.providerName] = value;
          return state;
        });
      },
    );
  }
}
