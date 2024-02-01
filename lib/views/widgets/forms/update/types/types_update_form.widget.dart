import 'package:communitybank/controllers/forms/on_changed/type/type.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/type/type.validator.dart';
import 'package:communitybank/functions/crud/types/types_crud.function.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/type_product_selection/types_product_selection.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:communitybank/models/data/type/type.model.dart';

class TypesUpdateForm extends StatefulHookConsumerWidget {
  final Type type;
  const TypesUpdateForm({
    super.key,
    required this.type,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TypesUpdateFormState();
}

class _TypesUpdateFormState extends ConsumerState<TypesUpdateForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    const formCardWidth = 500.0;
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      content: Consumer(builder: (context, ref, child) {
        return SingleChildScrollView(
          child: Container(
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
                            text: 'Type',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                          IconButton(
                            onPressed: () {
                              showValidatedButton.value
                                  ? Navigator.of(context).pop()
                                  : () {};
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
                        height: 15.0,
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            width: formCardWidth,
                            child: CBTextFormField(
                              label: 'Nom',
                              hintText: 'Nom',
                              initialValue: widget.type.name,
                              isMultilineTextForm: false,
                              obscureText: false,
                              textInputType: TextInputType.name,
                              validator: TypeValidators.typeName,
                              onChanged: TypeOnChanged.typeName,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            width: formCardWidth,
                            child: CBTextFormField(
                              label: 'Mise',
                              hintText: 'Mise',
                              initialValue: widget.type.stake.toString(),
                              isMultilineTextForm: false,
                              obscureText: false,
                              textInputType: TextInputType.name,
                              validator: TypeValidators.typeStack,
                              onChanged: TypeOnChanged.typeStake,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CBText(
                          text: 'Produits',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                        CBAddButton(
                          onTap: () {
                            ref
                                .read(typeAddedInputsProvider.notifier)
                                .update((state) {
                              return {
                                ...state,
                                DateTime.now().millisecondsSinceEpoch: true,
                              };
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final inputsMaps = ref.watch(typeAddedInputsProvider);
                      List<Widget> inputsWidgetsList = [];

                      for (MapEntry mapEntry in inputsMaps.entries) {
                        // verify if the current mapEntry key is equal to
                        // the id of one of type products
                        if (widget.type.productsIds.any(
                          (productId) => productId == mapEntry.key,
                        )) {
                          // if true, add a new type product selection and pass the
                          // equivalent product to it
                          inputsWidgetsList.add(
                            TypeProductSelection(
                              index: mapEntry.key,
                              isVisible: mapEntry.value,
                              productSelectionDropdownProvider:
                                  'type-selection-update-product-${mapEntry.key}',
                              productId: widget.type.productsIds.firstWhere(
                                (productId) => productId! == mapEntry.key,
                              ),
                              // mapEntry.key is equal to the product id
                              // since the products ids and numbers are stored
                              // in the same order, the index of product the id
                              // is equal to the product number
                              // that's why
                              productNumber: widget.type.productsNumber[widget
                                  .type.productsIds
                                  .indexOf(mapEntry.key)],
                              formCardWidth: formCardWidth,
                            ),
                          );
                        } else {
                          inputsWidgetsList.add(
                            TypeProductSelection(
                              index: mapEntry.key,
                              isVisible: mapEntry.value,
                              productSelectionDropdownProvider:
                                  'type-selection-update-product-${mapEntry.key}',
                              formCardWidth: formCardWidth,
                            ),
                          );
                        }
                      }

                      return Column(
                        children: inputsWidgetsList,
                      );
                    },
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
                            showValidatedButton.value
                                ? Navigator.of(context).pop()
                                : () {};
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
                                  await TypeCRUDFunctions.update(
                                    context: context,
                                    formKey: formKey,
                                    ref: ref,
                                    type: widget.type,
                                    showValidatedButton: showValidatedButton,
                                  );
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
      }),
    );
  }
}
