import 'package:communitybank/controllers/forms/on_changed/settlement/settlement.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/settlement/settlement.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/settlements/settlements_crud.function.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/definitions/cash_operations/cash_operations_infos/cash_operations_customer_card_infos/cash_operations_customer_card_infos.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class SettlementAddingForm extends StatefulHookConsumerWidget {
  const SettlementAddingForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SettlementAddingFormState();
}

class _SettlementAddingFormState extends ConsumerState<SettlementAddingForm> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    initializeDateFormatting('fr');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    const formCardWidth = 500.0;
    final settlementCollectionDate =
        ref.watch(settlementCollectionDateProvider);
    final format = DateFormat.yMMMEd('fr');
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
                        text: 'Règlement',
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        width: formCardWidth,
                        child: const CBTextFormField(
                          label: 'Nombre',
                          hintText: 'Nombre',
                          isMultilineTextForm: false,
                          obscureText: false,
                          textInputType: TextInputType.name,
                          validator: SettlementValidors.settlementNumber,
                          onChanged: SettlementOnChanged.settlementName,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5.0,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CBIconButton(
                              icon: Icons.date_range,
                              text: 'Date de Collecte',
                              onTap: () {
                                FunctionsController.showDateTime(
                                  context,
                                  ref,
                                  settlementCollectionDateProvider,
                                );
                              },
                            ),
                            CBText(
                              text: settlementCollectionDate != null
                                  ? '${format.format(settlementCollectionDate).toUpperCase()}  ${settlementCollectionDate.hour}:${settlementCollectionDate.minute}'
                                  : '',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            //   const SizedBox(),
                          ],
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
                              SettlementCRUDFunctions.create(
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
