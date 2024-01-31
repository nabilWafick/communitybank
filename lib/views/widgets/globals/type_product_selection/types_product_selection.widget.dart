import 'package:communitybank/controllers/forms/on_changed/type/type.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/type/type.validator.dart';
import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/products/products_list/products_list.dart';
import 'package:communitybank/views/widgets/globals/type_product_selection_dropdown/type_product_selection_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/type_product_selection_textformfield/type_product_selection_textformfield.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TypeProductSelection extends StatefulHookConsumerWidget {
  final int index;
  final bool isVisible;
  final String productSelectionDropdownProvider;
  final int? productId;
  final int? productNumber;
  final double formCardWidth;
  const TypeProductSelection({
    super.key,
    required this.index,
    required this.isVisible,
    required this.productSelectionDropdownProvider,
    this.productId,
    this.productNumber,
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
    final showWidget = useState(widget.isVisible);

    final typeSelectedProducts = ref.watch(typeSelectedProductsProvider);
    return showWidget.value
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
            width: formCardWidth,
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final productsListStream =
                    ref.watch(productsListStreamProvider);
                return productsListStream.when(
                  data: (data) {
                    if (widget.productId != null) {
                      Product? typeProduct;
                      for (Product product in data) {
                        if (product.id == widget.productId) {
                          typeProduct = product;
                          break;
                        }
                      }

                      data = [
                        typeProduct!,
                        ...data,
                      ];

                      data = data.toSet().toList();
                    }

                    final remainProducts = data
                        .where(
                          (product) =>
                              typeSelectedProducts.containsValue(product) ==
                              false,
                        )
                        .toList();

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CBTypeProductSelectionDropdown(
                              width: formCardWidth / 2.3,
                              label: 'Produit',
                              providerName:
                                  widget.productSelectionDropdownProvider,
                              dropdownMenuEntriesLabels: remainProducts,
                              dropdownMenuEntriesValues: remainProducts,
                            ),
                            SizedBox(
                              width: formCardWidth / 2.3,
                              child: CBTypeProductSelectionTextFormField(
                                inputIndex: widget.index,
                                label: 'Nombre',
                                hintText: 'Nombre de produit',
                                initialValue: widget.productNumber?.toString(),
                                textInputType: TextInputType.number,
                                validator: TypeValidators.typeProductNumber,
                                onChanged: TypeOnChanged.typeProductNumber,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            showWidget.value = false;
                            ref
                                .read(typeAddedInputsProvider.notifier)
                                .update((state) {
                              // if input is visible, hide it
                              state[widget.index] = showWidget.value;
                              //  debugPrint('typeAddedInputsProvider');
                              //  debugPrint(state.toString());

                              return state;
                            });

                            // remove the selected product from typeSelectedProducts
                            ref
                                .read(typeSelectedProductsProvider.notifier)
                                .update((state) {
                              // since typeSelectedProducts use type selection dropdown provider as key
                              state.remove(
                                  widget.productSelectionDropdownProvider);
                              // debugPrint('typeSelectedProductsProvider');
                              // debugPrint('length: ${state.length}');
                              // debugPrint(state.toString());
                              return state;
                            });
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                            color: CBColors.primaryColor,
                            size: 30.0,
                          ),
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) => const SizedBox(
                    width: formCardWidth / 2.3,
                  ),
                  loading: () => const SizedBox(
                    width: formCardWidth / 2.3,
                  ),
                );
              },
            ),
          )
        : const SizedBox();
  }
}
