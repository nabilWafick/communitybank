import 'package:communitybank/controllers/forms/on_changed/stock/stock.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/stock/stock.validator.dart';
import 'package:communitybank/functions/crud/customer_card/customer_card_crud.fuction.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/definitions/products/products_list/products_list.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/product/product_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/type/type_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StockAddingForm extends StatefulHookConsumerWidget {
  const StockAddingForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StockAddingFormState();
}

class _StockAddingFormState extends ConsumerState<StockAddingForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    final productsListStream = ref.watch(productsListStreamProvider);
    const formCardWidth = 500.0;
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      content: Container(
        // color: Colors.blueGrey,
        padding: const EdgeInsets.all(20.0),
        width: formCardWidth,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CBText(
                        text: 'Stock',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          color: CBColors.primaryColor,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 35.0,
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                          right: 50.0,
                          left: 10.0,
                        ),
                        width: formCardWidth / 1.16,
                        child: CBFormProductDropdown(
                          width: formCardWidth / 1.16,
                          menuHeigth: 500.0,
                          label: 'Produit',
                          providerName: 'stock-adding-product',
                          dropdownMenuEntriesLabels: productsListStream.when(
                            data: (data) => data,
                            error: (error, stackTrace) => [],
                            loading: () => [],
                          ),
                          dropdownMenuEntriesValues: productsListStream.when(
                            data: (data) => data,
                            error: (error, stackTrace) => [],
                            loading: () => [],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        width: formCardWidth,
                        child: const CBTextFormField(
                          label: 'Quantité',
                          hintText: 'Quantité',
                          isMultilineTextForm: false,
                          obscureText: false,
                          textInputType: TextInputType.number,
                          validator: StockValidators.stockQuantity,
                          onChanged: StockOnChanged.stockQuantity,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 35.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 170.0,
                    child: CBElevatedButton(
                      text: 'Fermer',
                      backgroundColor: CBColors.sidebarTextColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  showValidatedButton.value
                      ? SizedBox(
                          width: 170.0,
                          child: CBElevatedButton(
                            text: 'Valider',
                            onPressed: () async {
                              debugPrint(
                                DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                              );
                              /*   StockCRUDFunctions.create(
                                context: context,
                                formKey: formKey,
                                ref: ref,
                                showValidatedButton: showValidatedButton,
                              );*/
                            },
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
