import 'package:communitybank/controllers/forms/validators/customer_account/customer_account.validator.dart';
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final customerAccountOwnerCardTypeDropdownProvider =
    StateProvider.family<Type, String>((ref, providerName) {
  return Type(
    name: '',
    stake: 0,
    productsIds: [],
    productsNumber: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

class CBCustomerAccountOwnerCardTypeSelectionDropdown
    extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<Type> dropdownMenuEntriesLabels;
  final List<Type> dropdownMenuEntriesValues;
  final double? width;
  final double? menuHeigth;

  const CBCustomerAccountOwnerCardTypeSelectionDropdown({
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
      _CBCustomerAccountOwnerCardTypeSelectionDropdownState();
}

class _CBCustomerAccountOwnerCardTypeSelectionDropdownState
    extends ConsumerState<CBCustomerAccountOwnerCardTypeSelectionDropdown> {
  @override
  void initState() {
    Future.delayed(
        const Duration(
          milliseconds: 100,
        ), () {
// check if dropdown item is not empty so as to avoid error while setting the  the first item as the selectedItem
      if (widget.dropdownMenuEntriesValues.isNotEmpty) {
        ref
            .read(customerAccountOwnerCardTypeDropdownProvider(
                    widget.providerName)
                .notifier)
            .state = widget.dropdownMenuEntriesValues[0];
        // put the selected item in the selectedProduct map so as to reduce items for the remain dropdowns
        ref
            .read(customerAccountOwnerSelectedCardsTypesProvider.notifier)
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
    final selectedDropdownProduct = ref.watch(
        customerAccountOwnerCardTypeDropdownProvider(widget.providerName));

    return DropdownMenu(
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0.0),
            bottomLeft: Radius.circular(0.0),
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
          borderSide: BorderSide(color: CBColors.tertiaryColor, width: .5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(.0),
            bottomLeft: Radius.circular(.0),
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
          borderSide: BorderSide(color: CBColors.primaryColor, width: 2.0),
        ),
      ),
      width: widget.width,
      menuHeight: widget.menuHeigth,
      enableFilter: true,
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
        // put the selected item in the selectedProduct map so as to reduce items for the remain dropdowns

        // set the selected product
        ref
            .read(customerAccountOwnerCardTypeDropdownProvider(
                    widget.providerName)
                .notifier)
            .state = value!;
        // // remove the last selected product from tySelectedProducts
        // ref.read(typeSelectedProductsProvider.notifier).update((state) {
        //   // since typeSelectedProducts use type selection dropdown provider as key
        //   state.remove(widget.providerName);
        //   return state;
        // });

        // put the selected item in the selectedProduct map so as to reduce items for the remain dropdowns
        ref
            .read(customerAccountOwnerSelectedCardsTypesProvider.notifier)
            .update((state) {
          state[widget.providerName] = value;
          return state;
        });

        //  debugPrint('dropdown value: ${value.toString()}');
        //  debugPrint(ref.watch(typeSelectedProductsProvider).toString());
      },
    );
  }
}
