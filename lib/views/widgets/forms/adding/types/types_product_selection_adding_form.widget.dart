import 'package:communitybank/controllers/forms/on_changed/type/type.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/type/type.validator.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/products/products_list/products_list.dart';
import 'package:communitybank/views/widgets/globals/product_selection_dropdown/product_selection_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/product_selection_textformfield/product_selection_textformfield.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TypeProductSelection extends StatefulHookConsumerWidget {
  final int index;
  final double formCardWidth;
  const TypeProductSelection({
    super.key,
    required this.index,
    required this.formCardWidth,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TypeProductSelectionState();
}

class _TypeProductSelectionState extends ConsumerState<TypeProductSelection> {
  @override
  Widget build(BuildContext context) {
    const formCardWidth = 450.0;
    final showWidget = useState(true);
    final productsListStream = ref.watch(productsListStreamProvider);
    final typeSelectedProducts = ref.watch(typeSelectedProductsProvider);
    return showWidget.value
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
            width: formCardWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CBProductSelectionDropdown(
                      width: formCardWidth / 2.3,
                      label: 'Produit',
                      providerName:
                          'type-selection-adding-product-${widget.index}',
                      dropdownMenuEntriesLabels: productsListStream.when(
                        data: (data) => data
                            .where((product) =>
                                typeSelectedProducts.containsValue(product) ==
                                false)
                            .toList(),
                        error: (error, stackTrace) => [],
                        loading: () => [],
                      ),
                      dropdownMenuEntriesValues: productsListStream.when(
                        data: (data) => data
                            .where((product) =>
                                typeSelectedProducts.containsValue(product) ==
                                false)
                            .toList(),
                        error: (error, stackTrace) => [],
                        loading: () => [],
                      ),
                    ),
                    SizedBox(
                      width: formCardWidth / 2.3,
                      child: CBProductSelectionTextFormField(
                        inputIndex: widget.index,
                        label: 'Nombre',
                        hintText: 'Nombre de produit',
                        textInputType: TextInputType.number,
                        validator: TypeValidators.typeProductNumber,
                        onChanged: TypeOnChanged.typeProductNumber,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    setState(() {});
                    ref.read(typeAddedInputsProvider.notifier).update((state) {
                      /*  state.removeWhere(
                          (inputIndex) => widget.index == inputIndex);*/
                      state.remove(widget.index);
                      //state.clear();
                      return state;
                    });
                    showWidget.value = false;
                    // setState(() {});
                    debugPrint(
                        'remain: ${ref.watch(typeAddedInputsProvider).length.toString()}');
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: CBColors.primaryColor,
                    size: 30.0,
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
