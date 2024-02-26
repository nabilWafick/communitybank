import 'package:communitybank/controllers/forms/on_changed/settlement/settlement.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/settlement/settlement.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/settlements/settlements_crud.function.dart';
import 'package:communitybank/models/data/settlement/settlement.model.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/cash/cash_operations/cash_operations_search_options/cash_operations_search_options.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class SettlementUpdateForm extends StatefulHookConsumerWidget {
  final Settlement settlement;
  const SettlementUpdateForm({
    super.key,
    required this.settlement,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SettlementUpdateFormState();
}

class _SettlementUpdateFormState extends ConsumerState<SettlementUpdateForm> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    initializeDateFormatting('fr');
    super.initState();
    Future.delayed(
      const Duration(
        milliseconds: 100,
      ),
      () {
        ref.read(settlementNumberProvider.notifier).state =
            widget.settlement.number;
        ref.read(settlementCollectionDateProvider.notifier).state =
            widget.settlement.collectedAt;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    const formCardWidth = 500.0;
    final settlementCollectionDate =
        ref.watch(settlementCollectionDateProvider);
    final settlementNumber = ref.watch(settlementNumberProvider);
    final cashOperationsSelectedCustomerAccountOwnerSelectedCardType =
        ref.watch(
            cashOperationsSelectedCustomerAccountOwnerSelectedCardTypeProvider);

    final format = DateFormat.yMMMMEEEEd('fr');

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
                        child: CBTextFormField(
                          label: 'Nombre',
                          hintText: 'Nombre',
                          initialValue: widget.settlement.number.toString(),
                          isMultilineTextForm: false,
                          obscureText: false,
                          textInputType: TextInputType.name,
                          validator: SettlementValidors.settlementNumber,
                          onChanged: SettlementOnChanged.settlementName,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const CBText(
                              text: 'Montant: ',
                              fontSize: 12,
                            ),
                            CBText(
                              text:
                                  '${settlementNumber * cashOperationsSelectedCustomerAccountOwnerSelectedCardType!.stake.ceil()}f',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
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
                            const SizedBox(
                              width: 10.0,
                            ),
                            Flexible(
                              child: CBText(
                                text: settlementCollectionDate != null
                                    ? '${format.format(settlementCollectionDate)}  ${settlementCollectionDate.hour}:${settlementCollectionDate.minute}'
                                    : '',
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                                textOverflow: TextOverflow.ellipsis,
                              ),
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
                              SettlementCRUDFunctions.update(
                                context: context,
                                formKey: formKey,
                                ref: ref,
                                settlement: widget.settlement,
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
