// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/forms/validators/customer_card/customer_card.validator.dart';
import 'package:communitybank/controllers/forms/validators/settlement/settlement.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/customer_card/customer_card_crud.fuction.dart';
import 'package:communitybank/models/data/settlement/settlement.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/cash_operations/cash_operations_infos/cash_operations_customer_card_infos/cash_operations_customer_card_card/cash_operations_customer_card_card.widget.dart';
import 'package:communitybank/views/widgets/definitions/cash_operations/cash_operations_infos/cash_operations_customer_card_infos/cash_operations_customer_card_data/cash_operations_customer_card_data.widget.dart';
import 'package:communitybank/views/widgets/definitions/cash_operations/cash_operations_infos/cash_operations_customer_card_infos/cash_operations_customer_card_date_data/cash_operations_customer_card_date_data.widget.dart';
import 'package:communitybank/views/widgets/definitions/cash_operations/cash_operations_search_options/cash_operations_search_options.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards.widgets.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/forms/adding/settlement/settlement_adding_form.widget.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

final settlementsNumbersTotalProvider = StateProvider<int>((ref) {
  return 0;
});

class CashOperationsCustomerCardInfos extends ConsumerStatefulWidget {
  final double width;
  const CashOperationsCustomerCardInfos({super.key, required this.width});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CashOperationsCustomerCardInfosState();
}

class _CashOperationsCustomerCardInfosState
    extends ConsumerState<CashOperationsCustomerCardInfos> {
  @override
  void initState() {
    initializeDateFormatting('fr');
    /*
    Future.delayed(const Duration(milliseconds: 100), () {
      final cashOperationsSelectedCustomerAccountOwnerSelectedCard = ref.watch(
          cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider);

      ref.read(isCustomerCardSatisfiedProvider.notifier).state =
          cashOperationsSelectedCustomerAccountOwnerSelectedCard != null
              ? cashOperationsSelectedCustomerAccountOwnerSelectedCard
                      .satisfiedAt !=
                  null
              : false;

      ref.read(isCustomerCardRepaidProvider.notifier).state =
          cashOperationsSelectedCustomerAccountOwnerSelectedCard != null
              ? cashOperationsSelectedCustomerAccountOwnerSelectedCard
                      .repaidAt !=
                  null
              : false;

      ref.read(customerCardSatisfactionDateProvider.notifier).state =
          cashOperationsSelectedCustomerAccountOwnerSelectedCard?.satisfiedAt;

      ref.read(customerCardRepaymentDateProvider.notifier).state =
          cashOperationsSelectedCustomerAccountOwnerSelectedCard?.repaidAt;
    });
   */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cashOperationsSelectedCustomerAccount =
        ref.watch(cashOperationsSelectedCustomerAccountProvider);
    final cashOperationsSelectedCustomerAccountOwnerSelectedCard = ref
        .watch(cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider);
    final cashOperationsSelectedCustomerAccountOwnerCustomerCards = ref
        .watch(cashOperationsSelectedCustomerAccountOwnerCustomerCardsProvider);
    final customersCardsListStream =
        ref.watch(customersCardsListStreamProvider);
    final typesListStream = ref.watch(typesListStreamProvider);

    final cashOperationsSelectedCustomerAccountOwnerSelectedCardType =
        ref.watch(
            cashOperationsSelectedCustomerAccountOwnerSelectedCardTypeProvider);

    final cashOperationsSelectedCustomerAccountOwnerSelectedCardSettlements =
        ref.watch(
      cashOperationsSelectedCustomerAccountOwnerSelectedCardSettlementsProvider,
    );

    ref.watch(customerCardRepaymentDateProvider);
    final settlementsNumbersTotal = ref.watch(settlementsNumbersTotalProvider);

    final format = DateFormat.yMMMMEEEEd('fr');

    return Container(
      padding: const EdgeInsets.all(15.0),
      width: widget.width,
      height: 440.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          15.0,
        ),
        border: Border.all(
          color: CBColors.sidebarTextColor.withOpacity(.5),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CBText(
                text: 'Cartes: ',
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                width: widget.width * .88,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        cashOperationsSelectedCustomerAccountOwnerCustomerCards
                            .map(
                              (customerCard) => CustomerCardCard(
                                customerCard: customersCardsListStream.when(
                                  data: (data) {
                                    return data.firstWhere(
                                      (customerCardData) =>
                                          customerCardData.id ==
                                          customerCard.id,
                                    );
                                  },
                                  error: (error, stackTrace) => customerCard,
                                  loading: () => customerCard,
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            /*  margin: const EdgeInsetsDirectional.symmetric(
              vertical: 25.0,
            ),*/
            width: widget.width,
            //  color: CBColors.sidebarTextColor,
            child: StaggeredGrid.count(
              mainAxisSpacing: 7.0,
              crossAxisCount: 3,
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    return cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                            null
                        ? customersCardsListStream.when(
                            data: (data) {
                              final customerCard = data.firstWhere(
                                (customerCard) =>
                                    customerCard.id ==
                                    cashOperationsSelectedCustomerAccountOwnerSelectedCard
                                        .id,
                              );
                              return CustomerCardData(
                                label: 'Carte',
                                value: customerCard.label,
                              );
                            },
                            error: (error, stackTrace) =>
                                const CustomerCardData(
                              label: 'Carte',
                              value: '',
                            ),
                            loading: () => const CustomerCardData(
                              label: 'Carte',
                              value: '',
                            ),
                          )
                        : const CustomerCardData(
                            label: 'Carte',
                            value: '',
                          );
                  },
                ),

                /*  CustomerCardData(
                  label: 'Carte',
                  value:
                      cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                              null
                          ? customersCardsListStream.when(
                              data: (data) => data
                                  .firstWhere(
                                    (customerCard) =>
                                        customerCard.id ==
                                        cashOperationsSelectedCustomerAccountOwnerSelectedCard
                                            .id,
                                  )
                                  .label,
                              error: (error, stackTrace) => '',
                              loading: () => '',
                            )
                          : '',
                ),
              */

                Consumer(
                  builder: (context, ref, child) {
                    return cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                            null
                        ? typesListStream.when(
                            data: (data) {
                              final type = data.firstWhere(
                                (type) {
                                  return type.id ==
                                      cashOperationsSelectedCustomerAccountOwnerSelectedCard
                                          .typeId;
                                },
                              );
                              return CustomerCardData(
                                  label: 'Mise',
                                  value: '${type.stake.ceil()}f');
                            },
                            error: (error, stackTrace) =>
                                const CustomerCardData(
                                    label: 'Mise', value: ''),
                            loading: () => const CustomerCardData(
                                label: 'Mise', value: ''),
                          )
                        : const CustomerCardData(
                            label: 'Mise',
                            value: '',
                          );
                  },
                ),
                /*   CustomerCardData(
                  label: 'Mise',
                  value:
                      cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                              null
                          ? 
                          typesListStream.when(
                              data: (data) {
                                final stake = data
                                    .firstWhere(
                                      (type) {
                                        return type.id ==
                                            cashOperationsSelectedCustomerAccountOwnerSelectedCard
                                                .typeId;
                                      },
                                    )
                                    .stake
                                    .ceil();
                                return '${stake}f';
                              },
                              error: (error, stackTrace) => '',
                              loading: () => '',
                            )
                          : '',
                ),
             */
                Consumer(
                  builder: (context, ref, child) =>
                      cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                              null
                          ? const CustomerCardData(
                              label: 'Total Règlements',
                              value: '372',
                            )
                          : const CustomerCardData(
                              label: 'Total Règlements',
                              value: '',
                            ),
                ),

/*
             CustomerCardData(
                  label: 'Total Règlements',
                  value:
                      cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                              null
                          ? '372'
                          : '',
                ),
           */

                Consumer(
                  builder: (context, ref, child) {
                    return cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                            null
                        ? typesListStream.when(
                            data: (data) {
                              final type = data.firstWhere(
                                (type) {
                                  return type.id ==
                                      cashOperationsSelectedCustomerAccountOwnerSelectedCard
                                          .typeId;
                                },
                              );
                              return CustomerCardData(
                                  label: 'Type', value: type.name);
                            },
                            error: (error, stackTrace) =>
                                const CustomerCardData(
                                    label: 'Type', value: ''),
                            loading: () => const CustomerCardData(
                                label: 'Type', value: ''),
                          )
                        : const CustomerCardData(
                            label: 'Type',
                            value: '',
                          );
                  },
                ),

/*
           CustomerCardData(
                  label: 'Type',
                  value:
                      cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                              null
                          ? typesListStream.when(
                              data: (data) => data
                                  .firstWhere(
                                    (type) =>
                                        type.id ==
                                        cashOperationsSelectedCustomerAccountOwnerSelectedCard
                                            .typeId,
                                  )
                                  .name,
                              error: (error, stackTrace) => '',
                              loading: () => '',
                            )
                          : '',
                ),
          */

                Consumer(
                  builder: (context, ref, child) {
                    return cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                            null
                        ? cashOperationsSelectedCustomerAccountOwnerSelectedCardSettlements
                            .when(
                            data: (data) {
                              int settlementsNumber = 0;

                              for (Settlement settlement in data) {
                                settlementsNumber += settlement.number;
                              }
                              return CustomerCardData(
                                label: 'Montant Payé',
                                value:
                                    '${settlementsNumber * cashOperationsSelectedCustomerAccountOwnerSelectedCardType!.stake.ceil()}f',
                              );
                            },
                            error: (error, stackTrace) =>
                                const CustomerCardData(
                              label: 'Montant Payé',
                              value: '',
                            ),
                            loading: () => const CustomerCardData(
                              label: 'Montant Payé',
                              value: '',
                            ),
                          )
                        : const CustomerCardData(
                            label: 'Montant Payé',
                            value: '',
                          );
                  },
                ),

/*
           CustomerCardData(

                  label: 'Montant Payé',
                  value: cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                          null
                      ? cashOperationsSelectedCustomerAccountOwnerSelectedCardSettlements
                          .when(
                          data: (data) {
                            int settlementsNumber = 0;

                            for (Settlement settlement in data) {
                              settlementsNumber += settlement.number;
                            }
                            return '${settlementsNumber * cashOperationsSelectedCustomerAccountOwnerSelectedCardType!.stake.ceil()}';
                          },
                          error: (error, stackTrace) => '',
                          loading: () => '',
                        )
                      : '',
                ),
          */

                Consumer(
                  builder: (context, ref, child) {
                    return cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                            null
                        ? cashOperationsSelectedCustomerAccountOwnerSelectedCardSettlements
                            .when(
                            data: (data) {
                              int settlementsNumbersT = 0;

                              for (Settlement settlement in data) {
                                settlementsNumbersT += settlement.number;
                              }
                              Future.delayed(
                                const Duration(milliseconds: 100),
                                () {
                                  ref
                                      .read(settlementsNumbersTotalProvider
                                          .notifier)
                                      .state = settlementsNumbersT;
                                },
                              );

                              return CustomerCardData(
                                label: 'Règlements Effectués',
                                value: '$settlementsNumbersT',
                              );
                            },
                            error: (error, stackTrace) =>
                                const CustomerCardData(
                              label: 'Règlements Effectués',
                              value: '',
                            ),
                            loading: () => const CustomerCardData(
                              label: 'Règlements Effectués',
                              value: '',
                            ),
                          )
                        : const CustomerCardData(
                            label: 'Règlements Effectués',
                            value: '',
                          );
                  },
                ),

                /* CustomerCardData(
                  label: 'Règlements Effectués',
                  value: cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                          null
                      ? cashOperationsSelectedCustomerAccountOwnerSelectedCardSettlements
                          .when(
                          data: (data) {
                            int settlementsNumbersT = 0;

                            for (Settlement settlement in data) {
                              settlementsNumbersT += settlement.number;
                            }
                            Future.delayed(
                              const Duration(milliseconds: 100),
                              () {
                                ref
                                    .read(settlementsNumbersTotalProvider
                                        .notifier)
                                    .state = settlementsNumbersT;
                              },
                            );

                            return settlementsNumbersT.toString();
                          },
                          error: (error, stackTrace) => '',
                          loading: () => '',
                        )
                      : '',
                ),
             */
                const SizedBox(),
                Consumer(
                  builder: (context, ref, child) {
                    return cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                            null
                        ?
                        /*
                         isRepaid
                            ? CustomerCardData(
                                label: 'Reste à Payer',
                                value: '0f',
                              )
                            : */
                        cashOperationsSelectedCustomerAccountOwnerSelectedCardSettlements
                            .when(
                            data: (data) {
                              int settlementsNumber = 0;

                              for (Settlement settlement in data) {
                                settlementsNumber += settlement.number;
                              }
                              return CustomerCardData(
                                label: 'Reste à Payer',
                                value:
                                    '${(372 - settlementsNumber) * cashOperationsSelectedCustomerAccountOwnerSelectedCardType!.stake.ceil()}f',
                              );
                            },
                            error: (error, stackTrace) =>
                                const CustomerCardData(
                              label: 'Reste à Payer',
                              value: '',
                            ),
                            loading: () => const CustomerCardData(
                              label: 'Reste à Payer',
                              value: '',
                            ),
                          )
                        : const CustomerCardData(
                            label: 'Reste à Payer',
                            value: '',
                          );
                  },
                ),
                /*   CustomerCardData(
                  label: 'Reste à Payer',
                  value: cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                          null
                      ? isRepaid
                          ? '0'
                          : cashOperationsSelectedCustomerAccountOwnerSelectedCardSettlements
                              .when(
                              data: (data) {
                                int settlementsNumber = 0;

                                for (Settlement settlement in data) {
                                  settlementsNumber += settlement.number;
                                }
                                return '${(372 - settlementsNumber) * cashOperationsSelectedCustomerAccountOwnerSelectedCardType!.stake.ceil()}';
                              },
                              error: (error, stackTrace) => '',
                              loading: () => '',
                            )
                      : '',
                ),
             */

                Consumer(
                  builder: (context, ref, child) {
                    return cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                            null
                        ?
                        /* isRepaid
                            ? CustomerCardData(
                                label: 'Règlements Restants',
                                value: '0',
                              )
                            : */
                        cashOperationsSelectedCustomerAccountOwnerSelectedCardSettlements
                            .when(
                            data: (data) {
                              int settlementsNumber = 0;

                              for (Settlement settlement in data) {
                                settlementsNumber += settlement.number;
                              }
                              return CustomerCardData(
                                label: 'Reste à Payer',
                                value: '${(372 - settlementsNumber)}',
                              );
                            },
                            error: (error, stackTrace) =>
                                const CustomerCardData(
                              label: 'Règlements Restants',
                              value: '',
                            ),
                            loading: () => const CustomerCardData(
                              label: 'Règlements Restants',
                              value: '',
                            ),
                          )
                        : const CustomerCardData(
                            label: 'Règlements Restants',
                            value: '',
                          );
                  },
                ),
                /*    CustomerCardData(
                  label: 'Règlements Restants',
                  value: cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                          null
                      ? isRepaid
                          ? '0'
                          : cashOperationsSelectedCustomerAccountOwnerSelectedCardSettlements
                              .when(
                              data: (data) {
                                int settlementsNumber = 0;
                                for (Settlement settlement in data) {
                                  settlementsNumber += settlement.number;
                                }
                                return '${372 - settlementsNumber}';
                              },
                              error: (error, stackTrace) => '',
                              loading: () => '',
                            )
                      : '',
                ),
            */
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cashOperationsSelectedCustomerAccountOwnerSelectedCard != null
                  ? Consumer(
                      builder: (context, ref, child) {
                        return customersCardsListStream.when(
                          data: (data) {
                            final realTimeCustomerCardData = data.firstWhere(
                              (customerCardData) =>
                                  customerCardData.id ==
                                  cashOperationsSelectedCustomerAccountOwnerSelectedCard
                                      .id,
                            );

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 250.0,
                                  child: SwitchListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: .0,
                                      vertical: .0,
                                    ),
                                    splashRadius: .0,
                                    // isRepaid && && customerCardRepaymentDate != null
                                    // because, update switch state only after verify that
                                    // the date have be setted properly and isn't null
                                    // don't work,
                                    value: /*isRepaid &&
                                        customerCardRepaymentDate != null,
                                        */
                                        realTimeCustomerCardData.repaidAt !=
                                            null,
                                    title: const CBText(
                                      text: 'Remboursé',
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    onChanged: (value) async {
                                      // if the customerCard isn't satisfied
                                      if (/*isSatisfied == false &&
                                            customerCardSatisfactionDate ==
                                                null*/
                                          realTimeCustomerCardData
                                                  .satisfiedAt ==
                                              null) {
                                        // if switch will be switched to on
                                        if (value == true) {
                                          // verify if there is a least one settlement
                                          // on the customer card
                                          if (settlementsNumbersTotal > 0) {
                                            //  show dataTime picker for setting
                                            // repayment date
                                            await FunctionsController
                                                .showDateTime(
                                              context,
                                              ref,
                                              customerCardRepaymentDateProvider,
                                            );

                                            // if customerCard repayment is setted and not null
                                            if (ref.watch(
                                                    customerCardRepaymentDateProvider) !=
                                                null) {
                                              // do uptate

                                              await CustomerCardCRUDFunctions
                                                  .updateRepaymentDate(
                                                context: context,
                                                ref: ref,
                                                customerCard:
                                                    realTimeCustomerCardData,
                                              );
                                              /*
                                                // change switch state/value
                                                ref
                                                    .read(
                                                      isCustomerCardRepaidProvider
                                                          .notifier,
                                                    )
                                                    .state = value;
                                                    */
                                            }
                                          } else {
                                            ref
                                                .read(responseDialogProvider
                                                    .notifier)
                                                .state = ResponseDialogModel(
                                              serviceResponse:
                                                  ServiceResponse.failed,
                                              response:
                                                  'Aucun règlement n\'a été fait sur la carte',
                                            );

                                            FunctionsController.showAlertDialog(
                                              context: context,
                                              alertDialog:
                                                  const ResponseDialog(),
                                            );
                                          }
                                        } else {
                                          // admin update
                                        }
                                      }
                                    },
                                  ),
                                ),
                                CustomerCardDateData(
                                  label: 'Date de Remboursement',
                                  value: /* customerCardRepaymentDate != null &&
                                          isRepaid */
                                      realTimeCustomerCardData.repaidAt != null
                                          ? '${format.format(realTimeCustomerCardData.repaidAt!)}  ${realTimeCustomerCardData.repaidAt!.hour}:${realTimeCustomerCardData.repaidAt!.minute}'
                                          : '',
                                ),
                              ],
                            );
                          },
                          error: (error, stackTrace) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 250.0,
                                child: SwitchListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: .0,
                                    vertical: .0,
                                  ),
                                  splashRadius: .0,
                                  value: false,
                                  title: const CBText(
                                    text: 'Remboursé',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  onChanged: (value) async {},
                                ),
                              ),
                              const CustomerCardDateData(
                                label: 'Date de Remboursement',
                                value: '',
                              ),
                            ],
                          ),
                          loading: () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 250.0,
                                child: SwitchListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: .0,
                                    vertical: .0,
                                  ),
                                  splashRadius: .0,
                                  value: false,
                                  title: const CBText(
                                    text: 'Remboursé',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  onChanged: (value) async {},
                                ),
                              ),
                              const CustomerCardDateData(
                                label: 'Date de Remboursement',
                                value: '',
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 250.0,
                          child: SwitchListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: .0,
                              vertical: .0,
                            ),
                            splashRadius: .0,
                            value: false,
                            title: const CBText(
                              text: 'Remboursé',
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                            onChanged: (value) async {},
                          ),
                        ),
                        const CustomerCardDateData(
                          label: 'Date de Remboursement',
                          value: '',
                        ),
                      ],
                    ),
              /*  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250.0,
                    child: SwitchListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: .0,
                        vertical: .0,
                      ),
                      splashRadius: .0,
                      // isRepaid && && customerCardRepaymentDate != null
                      // because, update switch state only after verify that
                      // the date have be setted properly and isn't null
                      // don't work,
                      value: isRepaid && customerCardRepaymentDate != null,
                      title: const CBText(
                        text: 'Remboursé',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      onChanged: (value) async {
                        // check if a customer card is selected
                        if (cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                            null) {
                          // if the customerCard isn't satisfied
                          if (isSatisfied == false &&
                              customerCardSatisfactionDate == null) {
                            // if switch will be switched to on
                            if (value == true) {
                              // verify if there is a least one settlement
                              // on the customer card
                              if (settlementsNumbersTotal > 0) {
                                //  show dataTime picker for setting
                                // repayment date
                                await FunctionsController.showDateTime(
                                  context,
                                  ref,
                                  customerCardRepaymentDateProvider,
                                );

                                // if customerCard repayment is setted and not null
                                if (ref.watch(
                                        customerCardRepaymentDateProvider) !=
                                    null) {
                                  // do uptate

                                  await CustomerCardCRUDFunctions
                                      .updateRepaymentDate(
                                    context: context,
                                    ref: ref,
                                    customerCard:
                                        cashOperationsSelectedCustomerAccountOwnerSelectedCard,
                                  );
                                  // change switch state/value
                                  ref
                                      .read(
                                        isCustomerCardRepaidProvider.notifier,
                                      )
                                      .state = value;
                                }
                              } else {
                                ref
                                    .read(responseDialogProvider.notifier)
                                    .state = ResponseDialogModel(
                                  serviceResponse: ServiceResponse.failed,
                                  response:
                                      'Aucun règlement n\'a été fait sur la carte',
                                );

                                FunctionsController.showAlertDialog(
                                  context: context,
                                  alertDialog: const ResponseDialog(),
                                );
                              }
                            } else {
                              /* ref
                                  .read(
                                    customerCardRepaymentDateProvider.notifier,
                                  )
                                  .state = null;

                              ref
                                  .read(isCustomerCardRepaidProvider.notifier)
                                  .state = value;
                           */
                            }
                          }
                        }
                      },
                    ),
                  ),
                  CustomerCardDateData(
                    label: 'Date de Remboursement',
                    value: customerCardRepaymentDate != null && isRepaid
                        ? '${format.format(customerCardRepaymentDate)}  ${customerCardRepaymentDate.hour}:${customerCardRepaymentDate.minute}'
                        : '',
                  ),
                ],
              ),
            */

              cashOperationsSelectedCustomerAccountOwnerSelectedCard != null
                  ? Consumer(
                      builder: (context, ref, child) {
                        return customersCardsListStream.when(
                          data: (data) {
                            final realTimeCustomerCardData = data.firstWhere(
                              (customerCardData) =>
                                  customerCardData.id ==
                                  cashOperationsSelectedCustomerAccountOwnerSelectedCard
                                      .id,
                            );

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 250.0,
                                  child: SwitchListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: .0,
                                      vertical: .0,
                                    ),
                                    splashRadius: .0,
                                    // isRepaid && && customerCardRepaymentDate != null
                                    // because, update switch state only after verify that
                                    // the date have be setted properly and isn't null
                                    // don't work,
                                    value: /*isRepaid &&
                                        customerCardRepaymentDate != null,
                                        */
                                        realTimeCustomerCardData.satisfiedAt !=
                                            null,
                                    title: const CBText(
                                      text: 'Satisfait',
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    onChanged: (value) async {
                                      // if the customerCard isn't repaid
                                      if (/*isSatisfied == false &&
                                            customerCardSatisfactionDate ==
                                                null*/
                                          realTimeCustomerCardData.repaidAt ==
                                              null) {
                                        // if switch will be switched to on
                                        if (value == true) {
                                          // verify if the settlement number
                                          // total is equal to 372
                                          // on the customer card
                                          if (settlementsNumbersTotal == 372) {
                                            //  show dataTime picker
                                            // for setting satisfaction date

                                            await FunctionsController
                                                .showDateTime(
                                              context,
                                              ref,
                                              customerCardSatisfactionDateProvider,
                                            );

                                            // if customerCard satisfaction
                                            // date is setted and not null
                                            if (ref.watch(
                                                    customerCardSatisfactionDateProvider) !=
                                                null) {
                                              // do uptate

                                              await CustomerCardCRUDFunctions
                                                  .updateSatisfactionDate(
                                                context: context,
                                                ref: ref,
                                                customerCard:
                                                    realTimeCustomerCardData,
                                              );
                                            }
                                          } else {
                                            ref
                                                .read(responseDialogProvider
                                                    .notifier)
                                                .state = ResponseDialogModel(
                                              serviceResponse:
                                                  ServiceResponse.failed,
                                              response:
                                                  'Tous les règlements de la carte n\'ont pas été effectué',
                                            );

                                            FunctionsController.showAlertDialog(
                                              context: context,
                                              alertDialog:
                                                  const ResponseDialog(),
                                            );
                                          }
                                        } else {
                                          // admin update
                                        }
                                      }
                                    },
                                  ),
                                ),
                                CustomerCardDateData(
                                  label: 'Date de Satisfaction',
                                  value: /* customerCardRepaymentDate != null &&
                                          isRepaid */
                                      realTimeCustomerCardData.satisfiedAt !=
                                              null
                                          ? '${format.format(realTimeCustomerCardData.satisfiedAt!)}  ${realTimeCustomerCardData.satisfiedAt!.hour}:${realTimeCustomerCardData.satisfiedAt!.minute}'
                                          : '',
                                ),
                              ],
                            );
                          },
                          error: (error, stackTrace) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 250.0,
                                child: SwitchListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: .0,
                                    vertical: .0,
                                  ),
                                  splashRadius: .0,
                                  value: false,
                                  title: const CBText(
                                    text: 'Satisfait',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  onChanged: (value) async {},
                                ),
                              ),
                              const CustomerCardDateData(
                                label: 'Date de Satisfaction',
                                value: '',
                              ),
                            ],
                          ),
                          loading: () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 250.0,
                                child: SwitchListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: .0,
                                    vertical: .0,
                                  ),
                                  splashRadius: .0,
                                  value: false,
                                  title: const CBText(
                                    text: 'Satisfait',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  onChanged: (value) async {},
                                ),
                              ),
                              const CustomerCardDateData(
                                label: 'Date de Satisfaction',
                                value: '',
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 250.0,
                          child: SwitchListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: .0,
                              vertical: .0,
                            ),
                            splashRadius: .0,
                            value: false,
                            title: const CBText(
                              text: 'Satisfait',
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                            onChanged: (value) async {},
                          ),
                        ),
                        const CustomerCardDateData(
                          label: 'Date de Satisfaction',
                          value: '',
                        ),
                      ],
                    ),

              /*  
             Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250.0,
                    child: SwitchListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: .0,
                        vertical: .0,
                      ),
                      value:
                          isSatisfied && customerCardSatisfactionDate != null,
                      title: const CBText(
                        text: 'Satisfait',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      // isSatisfied && customerCardSatisfactionDate != null
                      // because, update switch state only after verify that
                      // the date have be setted properly and isn't null
                      // don't work,
                      onChanged: (value) async {
                        // check if a customer card is selected
                        if (cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                            null) {
                          // if the customerCard isn't repaid
                          if (isRepaid == false &&
                              customerCardRepaymentDate == null) {
                            // if switch will be switched to on
                            if (value == true) {
                              // verify if settlementsTotalNumbers is
                              // equal to 372 on the customer card

                              if (settlementsNumbersTotal == 372) {
                                //  show dataTime picker for setting
                                //  satisfaction date
                                await FunctionsController.showDateTime(
                                  context,
                                  ref,
                                  customerCardSatisfactionDateProvider,
                                );

                                // customer card satisfaction date is setted
                                // and is not null

                                if (ref.watch(
                                        customerCardSatisfactionDateProvider) !=
                                    null) {
                                  CustomerCardCRUDFunctions
                                      .updateSatisfactionDate(
                                    context: context,
                                    ref: ref,
                                    customerCard:
                                        cashOperationsSelectedCustomerAccountOwnerSelectedCard,
                                  );
                                  // change switch state/value
                                  ref
                                      .read(
                                        isCustomerCardSatisfiedProvider
                                            .notifier,
                                      )
                                      .state = value;
                                }
                              } else {
                                ref
                                    .read(responseDialogProvider.notifier)
                                    .state = ResponseDialogModel(
                                  serviceResponse: ServiceResponse.failed,
                                  response:
                                      'Tous les règlements de la carte n\'ont pas été éffectués',
                                );

                                FunctionsController.showAlertDialog(
                                  context: context,
                                  alertDialog: const ResponseDialog(),
                                );
                              }
                            } else {
                              /*    ref
                                  .read(
                                    customerCardSatisfactionDateProvider
                                        .notifier,
                                  )
                                  .state = null;

                              ref
                                  .read(
                                    isCustomerCardSatisfiedProvider.notifier,
                                  )
                                  .state = value;
                          */
                            }
                          }
                        }
                      },
                    ),
                  ),
                  CustomerCardDateData(
                    label: 'Date de Satisfaction',
                    value: customerCardSatisfactionDate != null && isSatisfied
                        ? '${format.format(customerCardSatisfactionDate)}  ${customerCardSatisfactionDate.hour}:${customerCardSatisfactionDate.minute}'
                        : '',
                  ),
                ],
              ),
           */
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CBIconButton(
                icon: Icons.book,
                text: 'Situation du client',
                onTap: () {
                  cashOperationsSelectedCustomerAccount != null ? () {} : () {};
                },
              ),
              CBIconButton(
                icon: Icons.add_circle,
                text: 'Ajouter un règlement',
                onTap: () {
                  ref.read(settlementNumberProvider.notifier).state = 0;
                  ref.read(settlementCollectionDateProvider.notifier).state =
                      null;
                  cashOperationsSelectedCustomerAccountOwnerSelectedCard != null
                      ? FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const SettlementAddingForm(),
                        )
                      : () {};
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
