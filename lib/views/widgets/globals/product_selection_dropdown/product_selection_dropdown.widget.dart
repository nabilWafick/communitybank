import 'package:communitybank/controllers/forms/validators/type/type.validator.dart';
import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final typeDropdownSelectedProductProvider =
    StateProvider.family<Product, String>((ref, providerName) {
  return Product(
    name: '',
    purchasePrice: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

class CBProductSelectionDropdown extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<Product> dropdownMenuEntriesLabels;
  final List<Product> dropdownMenuEntriesValues;
  final double? width;

  const CBProductSelectionDropdown({
    super.key,
    this.width,
    required this.label,
    required this.providerName,
    required this.dropdownMenuEntriesLabels,
    required this.dropdownMenuEntriesValues,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CBProductSelectionDropdownState();
}

class _CBProductSelectionDropdownState
    extends ConsumerState<CBProductSelectionDropdown> {
  @override
  void initState() {
    Future.delayed(
        const Duration(
          milliseconds: 100,
        ), () {
      if (widget.dropdownMenuEntriesValues.isNotEmpty) {
        ref
            .read(typeDropdownSelectedProductProvider(widget.providerName)
                .notifier)
            .state = widget.dropdownMenuEntriesValues[0];
        ref.read(typeSelectedProductsProvider.notifier).update((state) {
          state[widget.providerName] = widget.dropdownMenuEntriesValues[0];
          return state;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDropdownProduct =
        ref.watch(typeDropdownSelectedProductProvider(widget.providerName));
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
        ref
            .read(typeDropdownSelectedProductProvider(widget.providerName)
                .notifier)
            .state = value!;

        ref.read(typeSelectedProductsProvider.notifier).update((state) {
          state[widget.providerName] = value;
          return state;
        });
      },
    );
  }
}
