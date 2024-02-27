import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/activities/customer_periodic_activity/customer_periodic_activity_data/customer_periodic_activity_data.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards_list/customers_cards_list.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ActivityCustomerCardCard extends ConsumerWidget {
  final CustomerCard customerCard;
  const ActivityCustomerCardCard({
    super.key,
    required this.customerCard,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerPeriodicActivitySelectedCustomerCard =
        ref.watch(customerPeriodicActivitySelectedCustomerCardProvider);

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
      color: customerPeriodicActivitySelectedCustomerCard != null &&
              customerPeriodicActivitySelectedCustomerCard.id == customerCard.id
          ? Colors.white
          : CBColors.primaryColor,
      child: InkWell(
        onTap: () async {
          ref
              .read(
                  customerPeriodicActivitySelectedCustomerCardProvider.notifier)
              .state = customerCard;
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            child: Consumer(
              builder: (context, ref, child) {
                final customersCardsListStream =
                    ref.watch(customersCardsListStreamProvider);

                return customersCardsListStream.when(
                  data: (data) {
                    /* String customerCardLabel = '';

                    for (CustomerCard customerCard in data) {
                      if (customerCard.id ==
                          customerPeriodicActivitySelectedCustomerCard
                              .id) {
                        customerCardLabel = customerCard.label;
                      }
                    }*/

                    final realTimeCustomerCard = data.firstWhere(
                      (realTimeCustomerCard) =>
                          customerCard.id == realTimeCustomerCard.id,
                      orElse: () => CustomerCard(
                        label: '',
                        typeId: 0,
                        typeNumber: 0,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
                    );

                    return CBText(
                      text: realTimeCustomerCard.label,

                      // sidebarSubOptionData.name
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: customerPeriodicActivitySelectedCustomerCard !=
                                  null &&
                              customerPeriodicActivitySelectedCustomerCard.id ==
                                  customerCard.id
                          ? CBColors.primaryColor
                          : Colors.white,
                    );
                  },
                  error: (error, stackTrace) => CBText(
                    text: customerCard.label,

                    // sidebarSubOptionData.name
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: customerPeriodicActivitySelectedCustomerCard !=
                                null &&
                            customerPeriodicActivitySelectedCustomerCard.id ==
                                customerCard.id
                        ? CBColors.primaryColor
                        : Colors.white,
                  ),
                  loading: () => CBText(
                    text: '',

                    // sidebarSubOptionData.name
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: customerPeriodicActivitySelectedCustomerCard !=
                                null &&
                            customerPeriodicActivitySelectedCustomerCard.id ==
                                customerCard.id
                        ? CBColors.primaryColor
                        : Colors.white,
                  ),
                );
              },
            )),
      ),
    );
  }
}
