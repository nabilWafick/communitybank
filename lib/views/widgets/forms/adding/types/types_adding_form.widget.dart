import 'package:communitybank/controllers/forms/on_changed/type/type.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/type/type.validator.dart';
import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/definitions/products/products_list/products_list.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'types_product_selection_adding_form.widget.dart';

class TypesAddingForm extends StatefulHookConsumerWidget {
  const TypesAddingForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TypesAddingFormState();
}

class _TypesAddingFormState extends ConsumerState<TypesAddingForm> {
  @override
  /*
  void initState() {
    ref.watch(productsListStreamProvider).when(
        data: (data) {
          ref.read(availableProductsProvider.notifier).state = data;
        },
        error: (error, stackTrace) {},
        loading: () {});
    super.initState();
  }
*/

/*
  void onRemoveInput({required int inputIndex}) {
    ref.read(addedInputsProvider.notifier).update((state) {
      state.remove((index) => index == inputIndex);
      //state.clear();
      return state;
    });
    // showWidget.value = false;
    setState(() {});
  }*/

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //  final showValidatedButton = useState<bool>(true);
    final addedInputs = ref.watch(addedInputsProvider);
    const formCardWidth = 500.0;
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      content: Consumer(builder: (context, ref, child) {
        return Container(
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
                      height: 15.0,
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          width: formCardWidth,
                          child: const CBTextFormField(
                            label: 'Nom',
                            hintText: 'Nom',
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
                          child: const CBTextFormField(
                            label: 'Mise',
                            hintText: 'Mise',
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
                      StatefulBuilder(builder: (context, setStatef) {
                        return CBAddButton(
                          onTap: () {
                            setStatef(() {});
                            ref
                                .read(addedInputsProvider.notifier)
                                .update((state) {
                              return [
                                ...state,
                                DateTime.now().millisecondsSinceEpoch,
                              ];
                            } /*{
                              state.add(
                                DateTime.now().millisecondsSinceEpoch,
                              );
                              return state;
                            }*/
                                    );
                            setStatef(() {});
                            debugPrint('added: ${addedInputs.length}');
                            setState(() {});
                          },
                        );
                      })
                    ],
                  ),
                ),
                /* for (int i = 0; i < addedInputsNumber; ++i)
                    const TypeProductSelection(
                      formCardWidth: formCardWidth,
                      index: 
                      ,
                    ),*/

                Consumer(builder: (context, ref, child) {
                  final inputs = ref.watch(addedInputsProvider);
                  return Column(
                    children: inputs
                        .map(
                          (index) => TypeProductSelection(
                            formCardWidth: formCardWidth,
                            index: index,
                            //   onRemove: onRemoveInput,
                          ),
                        )
                        .toList(),
                  );
                })

                /* ...addedInputs.map(
                    (index) => TypeProductSelection(
                      formCardWidth: formCardWidth,
                      index: index,
                      //   onRemove: onRemoveInput,
                    ),
                  ),*/
                ,
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
                    SizedBox(
                      width: 170.0,
                      child: CBElevatedButton(
                        text: 'Valider',
                        onPressed: () {
                          setState(() {});
                          formKey.currentState!.save();
                          final isFormValid = formKey.currentState!.validate();
                          if (isFormValid) {
                            final typeName = ref.watch(typeNameProvider);
                            final typeStack = ref.watch(typeStakeProvider);
                            final typeSelectedProducts =
                                ref.watch(typeSelectedProductsProvider);
                            // store the selected products
                            List<Product> typeProducts = [];
                            typeSelectedProducts.forEach((key, product) {
                              typeProducts.add(product);
                            });
                            // get the number of each selected product
                            final typeProductsNumber = addedInputs
                                .map((input) =>
                                    ref.watch(typeProductNumberProvider(input)))
                                .toList();

                            debugPrint('typeName: $typeName');
                            debugPrint('typeStack: $typeStack');

                            for (int i = 0;
                                i < typeProductsNumber.length;
                                ++i) {
                              typeProducts[i].number = typeProductsNumber[i];

                              debugPrint(
                                  'typeProductNumber $i-${typeProducts[i].name}: ${typeProducts[i].number}');

                              final type = Type(
                                name: typeName,
                                stake: typeStack,
                                products: typeProducts,
                                createdAt: DateTime.now(),
                                updatedAt: DateTime.now(),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
