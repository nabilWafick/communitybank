import 'package:communitybank/controllers/forms/validators/stock/stock.validator.dart';
import 'package:communitybank/functions/crud/stocks/stock_crud.function.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/forms/adding/stocks/constrained_output/product_selection/product_selection.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StockConstrainedOutputAddingForm extends StatefulHookConsumerWidget {
  const StockConstrainedOutputAddingForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StockConstrainedOutputAddingFormState();
}

class _StockConstrainedOutputAddingFormState
    extends ConsumerState<StockConstrainedOutputAddingForm> {
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
                        margin: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: const CBText(
                          text:
                              'Tous les règlements n\'ont pas été effectués sur la carte \nFaire une sortie par contrainte',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
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
                                    .read(
                                        stockConstrainedOuputAddedInputsProvider
                                            .notifier)
                                    .update(
                                  (state) {
                                    return {
                                      ...state,
                                      DateTime.now().millisecondsSinceEpoch:
                                          true,
                                    };
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      Consumer(builder: (context, ref, child) {
                        final inputsMaps =
                            ref.watch(stockConstrainedOuputAddedInputsProvider);
                        List<Widget> inputsWidgetsList = [];

                        for (MapEntry mapEntry in inputsMaps.entries) {
                          inputsWidgetsList.add(
                            StockConstrainedOutputProductSelection(
                              index: mapEntry.key,
                              isVisible: mapEntry.value,
                              productSelectionDropdownProvider:
                                  'stock-constrained-output-adding-product-${mapEntry.key}',
                              formCardWidth: formCardWidth,
                            ),
                          );
                        }

                        return Column(
                          children: inputsWidgetsList,
                        );
                      }),
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
                              StockCRUDFunctions.createStockConstrainedOutput(
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
      ),
    );
  }
}
