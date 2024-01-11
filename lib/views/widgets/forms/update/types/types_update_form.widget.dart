import 'package:communitybank/controllers/forms/on_changed/type/type.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/type/type.validator.dart';
import 'package:communitybank/functions/crud/types/types_crud.function.dart';
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/forms/adding/types/types_product_selection_adding_form.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    final typeAddedInputs = ref.watch(typeAddedInputsProvider);
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
                      StatefulBuilder(builder: (context, setStatef) {
                        return CBAddButton(
                          onTap: () {
                            setStatef(() {});
                            ref
                                .read(typeAddedInputsProvider.notifier)
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
                            debugPrint('added: ${typeAddedInputs.length}');
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
                  final inputs = ref.watch(typeAddedInputsProvider);
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
                    showValidatedButton.value
                        ? SizedBox(
                            width: 170.0,
                            child: CBElevatedButton(
                              text: 'Valider',
                              onPressed: () async {
                                await TypeCRUDFunctions.create(
                                  context: context,
                                  formKey: formKey,
                                  ref: ref,
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
        );
      }),
    );
  }
}
