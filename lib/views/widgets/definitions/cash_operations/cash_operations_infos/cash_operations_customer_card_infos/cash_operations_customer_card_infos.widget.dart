// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/forms/validators/customer_card/customer_card.validator.dart';
import 'package:communitybank/controllers/forms/validators/settlement/settlement.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/customer_card/customer_card_crud.fuction.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/data/settlement/settlement.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/cash_operations/cash_operations_search_options/cash_operations_search_options.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards.widgets.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/forms/adding/settlement/settlement_adding_form.widget.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
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
    final isSatisfied = ref.watch(isCustomerCardSatisfiedProvider);
    final isRepaid = ref.watch(isCustomerCardRepaidProvider);
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

    final customerCardSatisfactionDate =
        ref.watch(customerCardSatisfactionDateProvider);
    final customerCardRepaymentDate =
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
                CustomerCardInfos(
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
                CustomerCardInfos(
                  label: 'Mise',
                  value:
                      cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                              null
                          ? typesListStream.when(
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
                CustomerCardInfos(
                  label: 'Total Règlements',
                  value:
                      cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                              null
                          ? '372'
                          : '',
                ),
                CustomerCardInfos(
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
                CustomerCardInfos(
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
                CustomerCardInfos(
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
                const SizedBox(),
                CustomerCardInfos(
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
                CustomerCardInfos(
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
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                  CustomerCardInfosDate(
                    label: 'Date de Remboursement',
                    value: customerCardRepaymentDate != null && isRepaid
                        ? '${format.format(customerCardRepaymentDate)}  ${customerCardRepaymentDate.hour}:${customerCardRepaymentDate.minute}'
                        : '',
                  ),
                ],
              ),
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
                  CustomerCardInfosDate(
                    label: 'Date de Satisfaction',
                    value: customerCardSatisfactionDate != null && isSatisfied
                        ? '${format.format(customerCardSatisfactionDate)}  ${customerCardSatisfactionDate.hour}:${customerCardSatisfactionDate.minute}'
                        : '',
                  ),
                ],
              ),
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

class CustomerCardCard extends ConsumerWidget {
  final CustomerCard customerCard;
  const CustomerCardCard({
    super.key,
    required this.customerCard,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cashOperationsSelectedCustomerAccountOwnerSelectedCard = ref
        .watch(cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider);
    final customersCardsListStream =
        ref.watch(customersCardsListStreamProvider);
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: const BorderSide(
          color: CBColors.primaryColor,
        ),
      ),
      elevation: 7.0,
      color: cashOperationsSelectedCustomerAccountOwnerSelectedCard!.id ==
              customerCard.id
          ? Colors.white
          : CBColors.primaryColor,
      child: InkWell(
        onTap: () async {
          ref
              .read(
                  cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider
                      .notifier)
              .state = customerCard;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 15.0,
          ),
          child: Row(
            children: [
              CBText(
                text: customersCardsListStream.when(
                  data: (data) {
                    final customerCardRealTime = data.firstWhere(
                      (customerCardData) =>
                          customerCardData.id == customerCard.id,
                    );

                    return customerCardRealTime.label;
                  },
                  error: (error, stackTrace) => '',
                  loading: () => '',
                ),

                // sidebarSubOptionData.name
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color:
                    cashOperationsSelectedCustomerAccountOwnerSelectedCard.id ==
                            customerCard.id
                        ? CBColors.primaryColor
                        : Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomerCardInfos extends ConsumerWidget {
  final String label;
  final String value;
  const CustomerCardInfos({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      // width: 240.0,
      child: Row(
        children: [
          CBText(
            text: '$label: ',
            fontSize: 11,
            //  fontWeight: FontWeight.w500,
          ),
          CBText(
            text: value,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            //  color: CBColors.tertiaryColor,
          )
        ],
      ),
    );
  }
}

class CustomerCardInfosDate extends ConsumerWidget {
  final String label;
  final String value;
  const CustomerCardInfosDate({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      // width: 240.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CBText(
            text: label,
            fontSize: 11,
            //  fontWeight: FontWeight.w500,
          ),
          CBText(
            text: value,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            //  color: CBColors.tertiaryColor,
          )
        ],
      ),
    );
  }
}

class CBIconButton extends ConsumerWidget {
  final IconData icon;
  final String text;
  final Function() onTap;

  const CBIconButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(
          //   vertical: 10.0,
          ),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 5.0,
          color: CBColors.primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(
                icon,
                color: CBColors.backgroundColor,
              ),
              const SizedBox(
                width: 15.0,
              ),
              CBText(
                text: text,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: CBColors.backgroundColor,
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class CBAddSettlementButton extends ConsumerWidget {
  final Function() onTap;
  const CBAddSettlementButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(
          //   vertical: 10.0,
          ),
      child: InkWell(
        onTap: onTap,
        child: const Card(
          elevation: 5.0,
          color: CBColors.primaryColor,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(
                Icons.add_circle,
                color: CBColors.backgroundColor,
              ),
              SizedBox(
                width: 15.0,
              ),
              CBText(
                text: 'Ajouter un règlement',
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: CBColors.backgroundColor,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
