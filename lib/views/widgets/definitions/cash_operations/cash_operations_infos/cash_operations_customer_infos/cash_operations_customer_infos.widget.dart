import 'package:communitybank/controllers/forms/validators/customer_card/customer_card.validator.dart';
import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/cash_operations/cash_operations_search_options/cash_operations_search_options.widget.dart';
import 'package:communitybank/views/widgets/definitions/cash_operations/cash_operations_search_options/cash_operations_search_options_custumer_account_dropdown/cash_operations_search_options_customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/definitions/collectors/collectors_list/collectors_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers/customers.widgets.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards_list/customers_cards_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_categories/customers_categories_list/customers_categories_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/economical_activities/economical_activities.widgets.dart';
import 'package:communitybank/views/widgets/definitions/localities/localities_list/localities_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/personal_status/personal_status_list/personal_status_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CashOperationsCustomerInfos extends ConsumerWidget {
  final double width;
  const CashOperationsCustomerInfos({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  final cashOperationsSelectedCustomerAccount =
    //      ref.watch(cashOperationsSelectedCustomerAccountProvider);
    final customersListStream = ref.watch(customersListStreamProvider);
    final collectorsListStream = ref.watch(collectorsListStreamProvider);
    final cashOperationsSelectedCustomerAccountOwner =
        ref.watch(cashOperationsSelectedCustomerAccountOwnerProvider);
    final cashOperationsSelectedCustomerAccountCollector =
        ref.watch(cashOperationsSelectedCustomerAccountCollectorProvider);
    final categoriesListStream =
        ref.watch(custumersCategoriesListStreamProvider);
    final economicalActivitiesListStream =
        ref.watch(economicalActivityListStreamProvider);
    final personalStatusListStream =
        ref.watch(personalStatusListStreamProvider);
    final localitiesListStream = ref.watch(localityListStreamProvider);
    final customersCardsListStream =
        ref.watch(customersCardsListStreamProvider);
    final typesListStream = ref.watch(typesListStreamProvider);

    final cashOperationsSelectedCustomerAccountOwnerSelectedCard = ref
        .watch(cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider);

// listen for cash operations selected customer account provider (update)
// for updating account owner collector, setting the first customer card
// as the selected customer card

    ref.listen(
      cashOperationsSelectedCustomerAccountProvider,
      (previous, next) {
        Future.delayed(
            const Duration(
              milliseconds: 100,
            ), () {
          customersListStream.when(
            data: (data) {
              // set the current user account
              ref
                  .read(
                    cashOperationsSelectedCustomerAccountOwnerProvider.notifier,
                  )
                  .state = data.firstWhere((customer) =>
                      customer.id! ==
                      // watch the cash operations customer account dropdown
                      ref
                          .watch(cashOperationsSearchOptionsCustomerAccountDropdownProvider(
                              'cash-operations-search-options-customer-account'))!
                          .customerId
                  //   cashOperationsSelectedCustomerAccount!.customerId,
                  );
            },
            error: (error, stackTrace) {},
            loading: () {},
          );

          // update customer account collector
          collectorsListStream.when(
            data: (data) {
              // set the current ower account collector
              ref
                  .read(
                    cashOperationsSelectedCustomerAccountCollectorProvider
                        .notifier,
                  )
                  .state = data.firstWhere((collector) =>
                      collector.id! ==
                      // watch the cash operations customer account dropdown

                      ref
                          .watch(cashOperationsSearchOptionsCustomerAccountDropdownProvider(
                              'cash-operations-search-options-customer-account'))!
                          .collectorId

                  //  cashOperationsSelectedCustomerAccount!.collectorId,
                  );
            },
            error: (error, stackTrace) {},
            loading: () {},
          );

          //  update customer cards
          customersCardsListStream.when(
            data: (data) {
              ref
                  .read(
                    cashOperationsSelectedCustomerAccountOwnerCustomerCardsProvider
                        .notifier,
                  )
                  .state = data
                  .where(
                    (customerCard) => ref
                        .watch(cashOperationsSearchOptionsCustomerAccountDropdownProvider(
                            'cash-operations-search-options-customer-account'))!
                        .customerCardsIds!
                        .contains(customerCard.id!),
                  )
                  .toList();
              ref
                  .read(
                    cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider
                        .notifier,
                  )
                  .state = ref.watch(
                      cashOperationsSelectedCustomerAccountOwnerCustomerCardsProvider)[
                  0];
            },
            error: (error, stackTrace) {},
            loading: () {},
          );
        });
      },
    );

    // listening to cash operation selected customer card provider (update)
    // for updating the type data of the selected customer card, updating
    // the repayment date, the satisfaction date,
    // and their switch state provider

    ref.listen(cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider,
        (previous, next) {
      Future.delayed(const Duration(milliseconds: 100), () {
        // update  selected custumer card type
        typesListStream.when(
          data: (data) {
            ref
                .read(
                  cashOperationsSelectedCustomerAccountOwnerSelectedCardTypeProvider
                      .notifier,
                )
                .state = data.firstWhere(
              (type) =>
                  type.id ==
                  ref
                      .watch(
                        cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider,
                      )!
                      .typeId,
            );
          },
          error: (error, stackTrace) {},
          loading: () {},
        );

        // update for the selected custumer card
        // satisfaction and repayment date,
        // satisfaction and repayment switch state
        // provider(isRepaid, isSatified)

        final cashOperationsSelectedCustomerAccountOwnerSelectedCard =
            ref.watch(
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
    });

    // listening to customers cards list stream provider (data update)
    // for updating in real time the cash operations selected customer card

    ref.listen(customersCardsListStreamProvider, (previous, next) {
      debugPrint('new data');
      Future.delayed(const Duration(milliseconds: 100), () {
        if (cashOperationsSelectedCustomerAccountOwnerSelectedCard != null) {
          debugPrint('new data after selected card check');
          final realTimeCustomerCard = next.when(
              data: (data) => data.firstWhere((customerCard) =>
                  customerCard.id ==
                  cashOperationsSelectedCustomerAccountOwnerSelectedCard.id),
              error: (error, stackTrace) =>
                  cashOperationsSelectedCustomerAccountOwnerSelectedCard,
              loading: () =>
                  cashOperationsSelectedCustomerAccountOwnerSelectedCard);

          ref
              .read(
                  cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider
                      .notifier)
              .state = realTimeCustomerCard;
        }
      });
    });

    return Container(
      padding: const EdgeInsets.all(
        15.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          15.0,
        ),
        border: Border.all(
          color: CBColors.sidebarTextColor.withOpacity(.5),
          width: 1.5,
        ),
      ),
      height: 440.0,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CashOperationsCustomerProfil(
                customer: cashOperationsSelectedCustomerAccountOwner,
              ),
              CashOperationsCollectorProfil(
                collector: cashOperationsSelectedCustomerAccountCollector,
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15.0),
            width: width,
            child: StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 7.0,
              // crossAxisSpacing: 2.0,
              children: [
                OtherInfos(
                  label: 'Profession',
                  value: cashOperationsSelectedCustomerAccountOwner != null
                      ? cashOperationsSelectedCustomerAccountOwner.profession
                      : '',
                ),
                OtherInfos(
                  label: 'CNI/NPI',
                  value: cashOperationsSelectedCustomerAccountOwner != null
                      ? cashOperationsSelectedCustomerAccountOwner.nicNumber
                          .toString()
                      : '',
                ),
                OtherInfos(
                  label: 'Categorie',
                  value: cashOperationsSelectedCustomerAccountOwner != null &&
                          cashOperationsSelectedCustomerAccountOwner
                                  .categoryId !=
                              null
                      ? categoriesListStream.when(
                          data: (data) => data
                              .firstWhere(
                                (category) =>
                                    category.id ==
                                    cashOperationsSelectedCustomerAccountOwner
                                        .categoryId,
                              )
                              .name,
                          error: (error, stackTrace) => '',
                          loading: () => '',
                        )
                      : '',
                ),
                OtherInfos(
                  label: 'Act. Économique',
                  value: cashOperationsSelectedCustomerAccountOwner != null &&
                          cashOperationsSelectedCustomerAccountOwner
                                  .economicalActivityId !=
                              null
                      ? economicalActivitiesListStream.when(
                          data: (data) => data
                              .firstWhere(
                                (economicalActivity) =>
                                    economicalActivity.id ==
                                    cashOperationsSelectedCustomerAccountOwner
                                        .economicalActivityId,
                              )
                              .name,
                          error: (error, stackTrace) => '',
                          loading: () => '',
                        )
                      : '',
                ),
                OtherInfos(
                  label: 'Stat. Personnel',
                  value: cashOperationsSelectedCustomerAccountOwner != null &&
                          cashOperationsSelectedCustomerAccountOwner
                                  .personalStatusId !=
                              null
                      ? personalStatusListStream.when(
                          data: (data) => data
                              .firstWhere(
                                (personalStatus) =>
                                    personalStatus.id ==
                                    cashOperationsSelectedCustomerAccountOwner
                                        .personalStatusId,
                              )
                              .name,
                          error: (error, stackTrace) => '',
                          loading: () => '',
                        )
                      : '',
                ),
                OtherInfos(
                  label: 'Localité',
                  value: cashOperationsSelectedCustomerAccountOwner != null &&
                          cashOperationsSelectedCustomerAccountOwner
                                  .localityId !=
                              null
                      ? localitiesListStream.when(
                          data: (data) => data
                              .firstWhere(
                                (locality) =>
                                    locality.id ==
                                    cashOperationsSelectedCustomerAccountOwner
                                        .localityId,
                              )
                              .name,
                          error: (error, stackTrace) => '',
                          loading: () => '',
                        )
                      : '',
                ),
              ],
            ),
          ),
          Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: CBColors.sidebarTextColor.withOpacity(.5),
                width: 1.5,
              ),
            ),
            child: Center(
              child: cashOperationsSelectedCustomerAccountOwner != null &&
                      cashOperationsSelectedCustomerAccountOwner.signature !=
                          null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      child: Image.network(
                        cashOperationsSelectedCustomerAccountOwner.signature!,
                      ),
                    )
                  : const Icon(
                      Icons.image,
                      color: CBColors.primaryColor,
                    ),
            ),
          )
        ],
      ),
    );
  }
}

class CashOperationsCustomerProfil extends ConsumerWidget {
  final Customer? customer;
  const CashOperationsCustomerProfil({super.key, this.customer});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Container(
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              50.0,
            ),
            border: Border.all(
              color: CBColors.sidebarTextColor.withOpacity(.5),
              width: 1.5,
            ),
          ),
          child: Center(
            child: customer != null && customer!.profile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(
                      50.0,
                    ),
                    child: Image.network(
                      customer!.profile!,
                    ),
                  )
                : const Icon(
                    Icons.person,
                    size: 30.0,
                    color: CBColors.primaryColor,
                  ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CBText(
              text: customer != null
                  ? '${customer!.firstnames} ${customer!.name}'
                  : '',
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
            CBText(
              text: customer != null ? customer!.phoneNumber : '',
              fontSize: 11.0,
            ),
          ],
        ),
      ],
    );
  }
}

class CashOperationsCollectorProfil extends ConsumerWidget {
  final Collector? collector;
  const CashOperationsCollectorProfil({super.key, this.collector});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Container(
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              50.0,
            ),
            border: Border.all(
              color: CBColors.sidebarTextColor.withOpacity(.5),
              width: 1.5,
            ),
          ),
          child: Center(
            child: collector != null && collector!.profile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(
                      50.0,
                    ),
                    child: Image.network(
                      collector!.profile!,
                    ),
                  )
                : const Icon(
                    Icons.person,
                    size: 30.0,
                    color: CBColors.primaryColor,
                  ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CBText(
              text: collector != null
                  ? '${collector!.firstnames} ${collector!.name}'
                  : '',
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
            CBText(
              text: collector != null ? collector!.phoneNumber : '',
              fontSize: 11.0,
            ),
          ],
        ),
      ],
    );
  }
}

class OtherInfos extends ConsumerWidget {
  final String label;
  final String value;
  const OtherInfos({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      //  width: 240.0,
      child: Row(
        children: [
          CBText(
            text: '$label: ',
            fontSize: 10.5,
            //  fontWeight: FontWeight.w500,
          ),
          CBText(
            text: value,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }
}
