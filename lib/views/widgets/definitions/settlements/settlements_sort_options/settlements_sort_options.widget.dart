import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards_list/customers_cards_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_card/customer_card_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettlementsSortOptions extends ConsumerWidget {
  const SettlementsSortOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customersCardsWithOwnerListStream =
        ref.watch(customersCardsWithOwnerListStreamProvider);
    return Container(
      margin: const EdgeInsets.only(
        bottom: 40.0,
      ),
      width: double.maxFinite,
      child: Column(
        children: [
          CBAddButton(
            onTap: () {
              //   ref.read(collectorPictureProvider.notifier).state = null;
              //   FunctionsController.showAlertDialog(
              //     context: context,
              //     alertDialog: const (),
              //   );
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CBSearchInput(
                hintText: 'Rechercher un règlement',
                searchProvider: searchProvider('settlements'),
              ),
              const SizedBox(
                width: 10.0,
              ),
              CBListCustomerCardDropdown(
                label: 'Carte',
                providerName: 'settlements-card',
                dropdownMenuEntriesLabels:
                    customersCardsWithOwnerListStream.when(
                  data: (data) => [
                    CustomerCard(
                      label: 'Tous',
                      typeId: 0,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues:
                    customersCardsWithOwnerListStream.when(
                  data: (data) => [
                    CustomerCard(
                      label: 'Tous',
                      typeId: 0,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
