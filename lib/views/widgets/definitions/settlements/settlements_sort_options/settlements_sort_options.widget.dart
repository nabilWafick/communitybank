//import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
//import 'package:communitybank/views/widgets/definitions/cash_operations/cash_operations_infos/cash_operations_customer_card_infos/cash_operations_customer_card_infos.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards_list/customers_cards_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/settlements/settlements_list/settlements_list.widget.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
//import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_card/customer_card_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
//import 'package:intl/intl.dart';

final settlementsListCollectionDateProvider = StateProvider<DateTime?>((ref) {
  return;
});
final settlementsListEntryDateProvider = StateProvider<DateTime?>((ref) {
  return;
});

class SettlementsSortOptions extends StatefulHookConsumerWidget {
  const SettlementsSortOptions({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SettlementsSortOptionsState();
}

class _SettlementsSortOptionsState
    extends ConsumerState<SettlementsSortOptions> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final customersCardsWithOwnerListStream =
        ref.watch(customersCardsWithOwnerListStreamProvider);
    //   final settlementsListCollectionDate =
    //       ref.watch(settlementsListCollectionDateProvider);
    //   final settlementsListEntryDate =
    //       ref.watch(settlementsListEntryDateProvider);

    //   final format = DateFormat.yMMMMEEEEd('fr');
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      width: double.maxFinite,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: CBIconButton(
                  icon: Icons.refresh,
                  text: 'Rafraichir',
                  onTap: () {
                    ref.invalidate(settlementsListStreamProvider);
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 10.0,
              ),
              /*   SizedBox(
                width: 320.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CBIconButton(
                      icon: Icons.date_range,
                      text: 'Date de Collecte',
                      onTap: () async {
                        await FunctionsController.showDateTime(
                          context,
                          ref,
                          settlementsListCollectionDateProvider,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: CBText(
                        text: settlementsListCollectionDate != null
                            ? '${format.format(settlementsListCollectionDate)}  ${settlementsListCollectionDate.hour}:${settlementsListCollectionDate.minute}'
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
              SizedBox(
                width: 320.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CBIconButton(
                      icon: Icons.date_range,
                      text: 'Date de Saisie',
                      onTap: () async {
                        await FunctionsController.showDateTime(
                          context,
                          ref,
                          settlementsListEntryDateProvider,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: CBText(
                        text: settlementsListEntryDate != null
                            ? '${format.format(settlementsListEntryDate)}  ${settlementsListEntryDate.hour}:${settlementsListEntryDate.minute}'
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
             */
              CBListCustomerCardDropdown(
                width: 200.0,
                label: 'Carte',
                providerName: 'settlements-card',
                dropdownMenuEntriesLabels:
                    customersCardsWithOwnerListStream.when(
                  data: (data) => [
                    CustomerCard(
                      label: 'Tous',
                      typeId: 0,
                      typeNumber: 1,
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
                      typeNumber: 1,
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
