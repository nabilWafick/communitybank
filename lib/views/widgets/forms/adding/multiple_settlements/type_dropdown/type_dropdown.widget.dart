import 'package:communitybank/controllers/forms/validators/multiple_settlements/multiple_settlements.validator.dart';
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final multipleSettlementsSelectedTypeDropdownProvider =
    StateProvider.family<Type, String>((ref, providerName) {
  return Type(
    name: '',
    stake: 0.0,
    productsIds: [],
    productsNumber: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

class CBMultipleSettlementsCustomerCardTypeDropdown
    extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<Type> dropdownMenuEntriesLabels;
  final List<Type> dropdownMenuEntriesValues;
  final double? width;
  final double? menuHeigth;

  const CBMultipleSettlementsCustomerCardTypeDropdown({
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
      _CBMultipleSettlementsCustomerCardTypeDropdownState();
}

class _CBMultipleSettlementsCustomerCardTypeDropdownState
    extends ConsumerState<CBMultipleSettlementsCustomerCardTypeDropdown> {
  @override
  void initState() {
    Future.delayed(
        const Duration(
          milliseconds: 100,
        ), () {
// check if dropdown item is not empty so as to avoid error while setting the  the first item as the selectedItem
      if (widget.dropdownMenuEntriesValues.isNotEmpty) {
        // set as selected value the first value found and which are not in
        // in selected group
        ref
            .read(multipleSettlementsSelectedTypeDropdownProvider(
                    widget.providerName)
                .notifier)
            .state = widget.dropdownMenuEntriesValues.firstWhere(
          (type) =>
              ref
                  .read(multipleSettlementsSelectedTypesProvider)
                  .containsValue(type) ==
              false,
          orElse: () => widget.dropdownMenuEntriesValues[0],
        );
        // put the selected item in the selectedType map so as to reduce items for the remain dropdowns
        ref
            .read(multipleSettlementsSelectedTypesProvider.notifier)
            .update((state) {
          state[widget.providerName] =
              widget.dropdownMenuEntriesValues.firstWhere(
            (type) =>
                ref
                    .read(multipleSettlementsSelectedTypesProvider)
                    .containsValue(type) ==
                false,
            orElse: () => widget.dropdownMenuEntriesValues[0],
          );
          return state;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDropdownType = ref.watch(
      multipleSettlementsSelectedTypeDropdownProvider(
        widget.providerName,
      ),
    );

    return DropdownMenu(
      width: widget.width,
      menuHeight: widget.menuHeigth,
      enableFilter: true,
      label: CBText(
        text: widget.label,
      ),
      hintText: widget.label,
      initialSelection: selectedDropdownType,
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
        // check if the value are not yet selected in another form

        if (ref
                .read(multipleSettlementsSelectedTypesProvider)
                .containsValue(value!) ==
            false) {
          // set the selected Type
          ref
              .read(multipleSettlementsSelectedTypeDropdownProvider(
                      widget.providerName)
                  .notifier)
              .state = value;
          // // remove the last selected Type from tySelectedTypes
          // ref.read(multipleSettlementsSelectedTypesProvider.notifier).update((state) {
          //   // since multipleSettlementsSelectedTypes use type selection dropdown provider as key
          //   state.remove(widget.providerName);
          //   return state;
          // });

          // put the selected item in the selectedType map so as to reduce items for the remain dropdowns
          ref
              .read(multipleSettlementsSelectedTypesProvider.notifier)
              .update((state) {
            state[widget.providerName] = value;
            return state;
          });

          //  debugPrint('dropdown value: ${value.toString()}');
          //  debugPrint(ref.watch(multipleSettlementsSelectedTypesProvider).toString());
        }
      },
    );
  }
}
