import 'package:communitybank/models/data/customers_category/customers_category.model.dart';
import 'package:communitybank/models/data/economical_activity/economical_activity.model.dart';
import 'package:communitybank/models/data/locality/locality.model.dart';
import 'package:communitybank/models/data/personal_status/personal_status.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/cash/cash_operations/cash_operations_infos/customer_infos/collector_profil/customer_profil.widget.dart';
import 'package:communitybank/views/widgets/cash/cash_operations/cash_operations_infos/customer_infos/customer_profil/customer_profil.widget.dart';
import 'package:communitybank/views/widgets/cash/cash_operations/search_options/customer_card_dropdown/customer_card_dropdown.widget.dart';
import 'package:communitybank/views/widgets/cash/cash_operations/search_options/custumer_account_dropdown/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/cash/cash_operations/search_options/search_options.widget.dart';
import 'package:communitybank/views/widgets/definitions/collectors/collectors_list/collectors_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers/customers.widgets.dart';
import 'package:communitybank/views/widgets/definitions/customers_accounts/customers_accounts.widgets.dart';
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
    final customersAccountsListStream =
        ref.watch(customersAccountsListStreamProvider);
    final cashOperationsSelectedCustomerAccount =
        ref.watch(cashOperationsSelectedCustomerAccountProvider);
    final customersListStream = ref.watch(customersListStreamProvider);
    final collectorsListStream = ref.watch(collectorsListStreamProvider);
    final cashOperationsSelectedCustomerAccountOwner =
        ref.watch(cashOperationsSelectedCustomerAccountOwnerProvider);
    final cashOperationsSelectedCustomerAccountCollector =
        ref.watch(cashOperationsSelectedCustomerAccountCollectorProvider);
    final customersCategoriesListStream =
        ref.watch(customersCategoriesListStreamProvider);
    final economicalActivitiesListStream =
        ref.watch(economicalActivitiesListStreamProvider);
    final personalStatusListStream =
        ref.watch(personalStatusListStreamProvider);
    final localitiesListStream = ref.watch(localitiesListStreamProvider);
    final customersCardsListStream =
        ref.watch(customersCardsListStreamProvider);
    final typesListStream = ref.watch(typesListStreamProvider);
    final cashOperationsSelectedCustomerAccountOwnerCustomerCards = ref
        .watch(cashOperationsSelectedCustomerAccountOwnerCustomerCardsProvider);

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

              // this check is doing because of refreshing effect

              if (ref.watch(
                      cashOperationsSearchOptionsCustomerAccountDropdownProvider(
                          'cash-operations-search-options-customer-account')) !=
                  null) {
                ref
                    .read(
                      cashOperationsSelectedCustomerAccountOwnerProvider
                          .notifier,
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
              }
            },
            error: (error, stackTrace) {},
            loading: () {},
          );

          // update customer account collector
          collectorsListStream.when(
            data: (data) {
              // set the current ower account collector
              if (ref.watch(
                      cashOperationsSearchOptionsCustomerAccountDropdownProvider(
                          'cash-operations-search-options-customer-account')) !=
                  null) {
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
              }
            },
            error: (error, stackTrace) {},
            loading: () {},
          );

          //  update customer cards
          customersCardsListStream.when(
            data: (data) {
              if (ref.watch(
                      cashOperationsSearchOptionsCustomerAccountDropdownProvider(
                          'cash-operations-search-options-customer-account')) !=
                  null) {
                ref
                    .read(
                      cashOperationsSelectedCustomerAccountOwnerCustomerCardsProvider
                          .notifier,
                    )
                    .state = data
                    .where(
                      (customerCard) =>
                          ref
                              .watch(
                                cashOperationsSearchOptionsCustomerAccountDropdownProvider(
                                    'cash-operations-search-options-customer-account'),
                              )!
                              .customerCardsIds
                              .contains(customerCard.id!) &&
                          customerCard.satisfiedAt == null &&
                          customerCard.repaidAt == null,
                    )
                    .toList();
              }

              if (ref
                  .watch(
                    cashOperationsSelectedCustomerAccountOwnerCustomerCardsProvider,
                  )
                  .isNotEmpty) {
                ref
                    .read(
                      cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider
                          .notifier,
                    )
                    .state = ref.watch(
                  cashOperationsSelectedCustomerAccountOwnerCustomerCardsProvider,
                )[0];
                ref
                    .read(
                        cashOperationsSearchOptionsCustomerCardDropdownProvider(
                      'cash-operations-search-options-customer-card',
                    ).notifier)
                    .state = ref.watch(
                  cashOperationsSelectedCustomerAccountOwnerCustomerCardsProvider,
                )[0];
              }

              // update cash operations customer card dropdown selected item
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
      //  debugPrint('selected customer card listener');

      Future.delayed(const Duration(milliseconds: 100), () {
        final cashOperationsSelectedCustomerAccountOwnerSelectedCard =
            ref.watch(
          cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider,
        );

/*

//?========
        //  update customer cards
        customersCardsListStream.when(
          data: (data) {
            if (ref.watch(
                    cashOperationsSearchOptionsCustomerAccountDropdownProvider(
                        'cash-operations-search-options-customer-account')) !=
                null) {
              ref
                  .read(
                    cashOperationsSelectedCustomerAccountOwnerCustomerCardsProvider
                        .notifier,
                  )
                  .state = data
                  .where(
                    (customerCard) =>
                        ref
                            .watch(
                              cashOperationsSearchOptionsCustomerAccountDropdownProvider(
                                  'cash-operations-search-options-customer-account'),
                            )!
                            .customerCardsIds
                            .contains(customerCard.id!) &&
                        customerCard.satisfiedAt == null &&
                        customerCard.repaidAt == null,
                  )
                  .toList();
            }

            if (ref
                .watch(
                  cashOperationsSelectedCustomerAccountOwnerCustomerCardsProvider,
                )
                .isNotEmpty) {
              ref
                  .read(
                    cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider
                        .notifier,
                  )
                  .state = ref.watch(
                cashOperationsSelectedCustomerAccountOwnerCustomerCardsProvider,
              )[0];
              ref
                  .read(cashOperationsSearchOptionsCustomerCardDropdownProvider(
                    'cash-operations-search-options-customer-card',
                  ).notifier)
                  .state = ref.watch(
                cashOperationsSelectedCustomerAccountOwnerCustomerCardsProvider,
              )[0];
            }

            // update cash operations customer card dropdown selected item
          },
          error: (error, stackTrace) {},
          loading: () {},
        );

//?========
*/
// if there is no account selected and selection begin by card or if the customer card selected is not for the owner of the previous customer card
        if (cashOperationsSelectedCustomerAccount == null ||
            cashOperationsSelectedCustomerAccountOwnerSelectedCard != null &&
                cashOperationsSelectedCustomerAccount.id !=
                    cashOperationsSelectedCustomerAccountOwnerSelectedCard
                        .customerAccountId) {
          customersAccountsListStream.when(
            data: (data) {
              // update the selected customer account dropdown
              if (cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                  null) {
                ref
                    .read(
                      cashOperationsSearchOptionsCustomerAccountDropdownProvider(
                              'cash-operations-search-options-customer-account')
                          .notifier,
                    )
                    .state = data.firstWhere(
                  (customerAccount) =>
                      customerAccount.id ==
                      cashOperationsSelectedCustomerAccountOwnerSelectedCard
                          .customerAccountId,
                  orElse: () => cashOperationsSelectedCustomerAccount!,
                );
              }

              // update cash operations customer account
              ref
                  .read(cashOperationsSelectedCustomerAccountProvider.notifier)
                  .state = data.firstWhere(
                (customerAccount) =>
                    customerAccount.id ==
                    cashOperationsSelectedCustomerAccountOwnerSelectedCard!
                        .customerAccountId,
                orElse: () => cashOperationsSelectedCustomerAccount!,
              );
            },
            error: (error, stackTrace) {},
            loading: () {},
          );
        }

        // update cash operations customer card dropdown selected item
        customersCardsListStream.when(
          data: (data) {
            if (cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                null) {
              ref
                  .read(cashOperationsSearchOptionsCustomerCardDropdownProvider(
                    'cash-operations-search-options-customer-card',
                  ).notifier)
                  .state = data.firstWhere(
                (customerCard) =>
                    cashOperationsSelectedCustomerAccountOwnerSelectedCard.id ==
                    customerCard.id,
              );
            }
          },
          error: (error, stackTrace) {},
          loading: () {},
        );

        // update  selected custumer card type
        typesListStream.when(
          data: (data) {
            if (cashOperationsSelectedCustomerAccountOwnerSelectedCard !=
                null) {
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
            }
          },
          error: (error, stackTrace) {},
          loading: () {},
        );

        // update for the selected custumer card
        // satisfaction and repayment date,
        // satisfaction and repayment switch state
        // provider(isRepaid, isSatified)
      });
    });

    // listening to customers cards list stream provider (data update)
    // for updating in real time the cash operations selected customer card

    ref.listen(customersCardsListStreamProvider, (previous, next) {
      //  debugPrint('new data');

      //  debugPrint('customer card list stream listener');

      Future.delayed(const Duration(milliseconds: 100), () {
        if (cashOperationsSelectedCustomerAccountOwnerSelectedCard != null) {
          //  debugPrint('new data after selected card check');
          final realTimeCustomerCard = next.when(
            data: (data) => data.firstWhere(
              (customerCard) =>
                  customerCard.id ==
                  cashOperationsSelectedCustomerAccountOwnerSelectedCard.id,
            ),
            error: (error, stackTrace) =>
                cashOperationsSelectedCustomerAccountOwnerSelectedCard,
            loading: () =>
                cashOperationsSelectedCustomerAccountOwnerSelectedCard,
          );

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
                cashOperationsSelectedCustomerAccountOwner != null
                    ? Consumer(
                        builder: (context, ref, child) {
                          return customersListStream.when(
                            data: (data) {
                              final realTimeCustomerData = data.firstWhere(
                                (customer) =>
                                    customer.id ==
                                    cashOperationsSelectedCustomerAccountOwner
                                        .id,
                              );
                              return OtherInfos(
                                label: 'Profession',
                                value: realTimeCustomerData.profession ?? '',
                              );
                            },
                            error: (error, stackTrace) => const OtherInfos(
                              label: 'Profession',
                              value: '',
                            ),
                            loading: () => const OtherInfos(
                              label: 'Profession',
                              value: '',
                            ),
                          );
                        },
                      )
                    : const OtherInfos(
                        label: 'Profession',
                        value: '',
                      ),
                cashOperationsSelectedCustomerAccountOwner != null
                    ? Consumer(
                        builder: (context, ref, child) {
                          return customersListStream.when(
                            data: (data) {
                              final realTimeCustomerData = data.firstWhere(
                                (customer) =>
                                    customer.id ==
                                    cashOperationsSelectedCustomerAccountOwner
                                        .id,
                              );
                              return OtherInfos(
                                label: 'CNI/NPI',
                                value: realTimeCustomerData.nicNumber
                                        ?.toString() ??
                                    '',
                              );
                            },
                            error: (error, stackTrace) => const OtherInfos(
                              label: 'CNI/NPI',
                              value: 'CNI/NPI',
                            ),
                            loading: () => const OtherInfos(
                              label: 'CNI/NPI',
                              value: '',
                            ),
                          );
                        },
                      )
                    : const OtherInfos(
                        label: 'CNI/NPI',
                        value: '',
                      ),
                cashOperationsSelectedCustomerAccountOwner != null
                    ? Consumer(
                        builder: (context, ref, child) {
                          return customersListStream.when(
                            data: (data) {
                              final realTimeCustomerData = data.firstWhere(
                                (customer) =>
                                    customer.id ==
                                    cashOperationsSelectedCustomerAccountOwner
                                        .id,
                              );

                              return customersCategoriesListStream.when(
                                data: (data) {
                                  final realTimeCategoryData = data.firstWhere(
                                    (category) =>
                                        category.id ==
                                        realTimeCustomerData.categoryId,
                                    orElse: () => CustomerCategory(
                                      name: 'Non définie',
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                    ),
                                  );
                                  return OtherInfos(
                                    label: 'Catégorie',
                                    value: realTimeCategoryData.name,
                                  );
                                },
                                error: (error, stackTrace) => const OtherInfos(
                                  label: 'Catégorie',
                                  value: '',
                                ),
                                loading: () => const OtherInfos(
                                  label: 'Catégorie',
                                  value: '',
                                ),
                              );
                            },
                            error: (error, stackTrace) => const OtherInfos(
                              label: 'Catégorie',
                              value: '',
                            ),
                            loading: () => const OtherInfos(
                              label: 'Catégorie',
                              value: '',
                            ),
                          );
                        },
                      )
                    : const OtherInfos(
                        label: 'Catégorie',
                        value: '',
                      ),
                cashOperationsSelectedCustomerAccountOwner != null
                    ? Consumer(
                        builder: (context, ref, child) {
                          return customersListStream.when(
                            data: (data) {
                              final realTimeCustomerData = data.firstWhere(
                                (customer) =>
                                    customer.id ==
                                    cashOperationsSelectedCustomerAccountOwner
                                        .id,
                              );

                              return economicalActivitiesListStream.when(
                                data: (data) {
                                  final realTimeEconomicalActivityData =
                                      data.firstWhere(
                                    (economicalActivity) =>
                                        economicalActivity.id ==
                                        realTimeCustomerData
                                            .economicalActivityId,
                                    orElse: () => EconomicalActivity(
                                      name: 'Non définie',
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                    ),
                                  );
                                  return OtherInfos(
                                    label: 'Act. Économique',
                                    value: realTimeEconomicalActivityData.name,
                                  );
                                },
                                error: (error, stackTrace) => const OtherInfos(
                                  label: 'Act. Économique',
                                  value: '',
                                ),
                                loading: () => const OtherInfos(
                                  label: 'Act. Économique',
                                  value: '',
                                ),
                              );
                            },
                            error: (error, stackTrace) => const OtherInfos(
                              label: 'Act. Économique',
                              value: '',
                            ),
                            loading: () => const OtherInfos(
                              label: 'Act. Économique',
                              value: '',
                            ),
                          );
                        },
                      )
                    : const OtherInfos(
                        label: 'Act. Économique',
                        value: '',
                      ),
                cashOperationsSelectedCustomerAccountOwner != null
                    ? Consumer(
                        builder: (context, ref, child) {
                          return customersListStream.when(
                            data: (data) {
                              final realTimeCustomerData = data.firstWhere(
                                (customer) =>
                                    customer.id ==
                                    cashOperationsSelectedCustomerAccountOwner
                                        .id,
                              );

                              return personalStatusListStream.when(
                                data: (data) {
                                  final realTimePersonalStatusData =
                                      data.firstWhere(
                                    (personalStatus) =>
                                        personalStatus.id ==
                                        realTimeCustomerData.personalStatusId,
                                    orElse: () => PersonalStatus(
                                      name: 'Non défini',
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                    ),
                                  );
                                  return OtherInfos(
                                    label: 'Stat. Personnel',
                                    value: realTimePersonalStatusData.name,
                                  );
                                },
                                error: (error, stackTrace) => const OtherInfos(
                                  label: 'Stat. Personnel',
                                  value: '',
                                ),
                                loading: () => const OtherInfos(
                                  label: 'Stat. Personnel',
                                  value: '',
                                ),
                              );
                            },
                            error: (error, stackTrace) => const OtherInfos(
                              label: 'Stat. Personnel',
                              value: '',
                            ),
                            loading: () => const OtherInfos(
                              label: 'Stat. Personnel',
                              value: '',
                            ),
                          );
                        },
                      )
                    : const OtherInfos(
                        label: 'Stat. Personnel',
                        value: '',
                      ),
                cashOperationsSelectedCustomerAccountOwner != null
                    ? Consumer(
                        builder: (context, ref, child) {
                          return customersListStream.when(
                            data: (data) {
                              final realTimeCustomerData = data.firstWhere(
                                (customer) =>
                                    customer.id ==
                                    cashOperationsSelectedCustomerAccountOwner
                                        .id,
                              );

                              return localitiesListStream.when(
                                data: (data) {
                                  final realTimeLocalityData = data.firstWhere(
                                    (locality) =>
                                        locality.id ==
                                        realTimeCustomerData.localityId,
                                    orElse: () => Locality(
                                      name: 'Localité',
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                    ),
                                  );
                                  return OtherInfos(
                                    label: 'Localité',
                                    value: realTimeLocalityData.name,
                                  );
                                },
                                error: (error, stackTrace) => const OtherInfos(
                                  label: 'Localité',
                                  value: '',
                                ),
                                loading: () => const OtherInfos(
                                  label: 'Localité',
                                  value: '',
                                ),
                              );
                            },
                            error: (error, stackTrace) => const OtherInfos(
                              label: 'Localité',
                              value: '',
                            ),
                            loading: () => const OtherInfos(
                              label: 'Localité',
                              value: '',
                            ),
                          );
                        },
                      )
                    : const OtherInfos(
                        label: 'Localité',
                        value: '',
                      ),

                // show vqlidated customer cards number
                cashOperationsSelectedCustomerAccountOwner != null
                    ? Consumer(
                        builder: (context, ref, child) {
                          int cashOperationsSelectedCustomerAccountOwnerUsableCustomerCard =
                              0;

                          for (int i = 0;
                              i <
                                  cashOperationsSelectedCustomerAccountOwnerCustomerCards
                                      .length;
                              i++) {
                            if (cashOperationsSelectedCustomerAccountOwnerCustomerCards[
                                            i]
                                        .satisfiedAt ==
                                    null &&
                                cashOperationsSelectedCustomerAccountOwnerCustomerCards[
                                            i]
                                        .repaidAt ==
                                    null) {
                              ++cashOperationsSelectedCustomerAccountOwnerUsableCustomerCard;
                            }
                          }
                          return OtherInfos(
                            label: 'Nombre de Cartes Non Statisfait',
                            value:
                                cashOperationsSelectedCustomerAccountOwnerUsableCustomerCard
                                    .toString(),
                          );
                        },
                      )
                    : const OtherInfos(
                        label: 'Nombre de Cartes Non Statisfait',
                        value: '',
                      )
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
              child: cashOperationsSelectedCustomerAccountOwner != null
                  ? customersListStream.when(
                      data: (data) {
                        final realtimeCustomerData = data.firstWhere(
                            (customer) =>
                                customer.id ==
                                cashOperationsSelectedCustomerAccountOwner.id);

                        return realtimeCustomerData.signature != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ),
                                child: Image.network(
                                  cashOperationsSelectedCustomerAccountOwner
                                      .signature!,
                                ),
                              )
                            : const Icon(
                                Icons.image,
                                color: CBColors.primaryColor,
                              );
                      },
                      error: (error, stackTrace) => const Icon(
                        Icons.image,
                        color: CBColors.primaryColor,
                      ),
                      loading: () => const Icon(
                        Icons.image,
                        color: CBColors.primaryColor,
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
            fontSize: 10,
            //  fontWeight: FontWeight.w500,
          ),
          CBText(
            text: value,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }
}
