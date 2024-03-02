import 'package:communitybank/controllers/forms/on_changed/settlement/settlement.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/settlement/settlement.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/settlements/settlements_crud.function.dart';
import 'package:communitybank/models/data/collection/collection.model.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/cash/cash_operations/cash_operations_infos/customer_card_infos/customer_card_card/customer_card_card.widget.dart';
import 'package:communitybank/views/widgets/cash/cash_operations/search_options/search_options.widget.dart';
import 'package:communitybank/views/widgets/cash/collections/collections.widgets.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards.widgets.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/type/type_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class MultipleSettlementsAddingForm extends StatefulHookConsumerWidget {
  const MultipleSettlementsAddingForm({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MultipleSettlementsAddingFormState();
}

class _MultipleSettlementsAddingFormState
    extends ConsumerState<MultipleSettlementsAddingForm> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    initializeDateFormatting('fr');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    final cashOperationsSelectedCustomerAccount =
        ref.watch(cashOperationsSelectedCustomerAccountProvider);
    final formCardWidth =
        cashOperationsSelectedCustomerAccount!.customerCardsIds.length > 1
            ? 1000.0
            : 500.0;
    final settlementCollectionDate =
        ref.watch(settlementCollectionDateProvider);
    final customersCardsListStream =
        ref.watch(customersCardsListStreamProvider);

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
                        text: 'Règlements Multiples',
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
                    height: 25.0,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          width: 450,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CBIconButton(
                                icon: Icons.date_range,
                                text: 'Date de Collecte',
                                onTap: () {
                                  FunctionsController.showDateTime(
                                    context: context,
                                    ref: ref,
                                    stateProvider:
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
                                      ? format.format(settlementCollectionDate)
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
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          width: 450.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CBText(
                                text: 'Montant Collecte Restant: ',
                                fontSize: 12.0,
                              ),
                              settlementCollectionDate != null
                                  ? Consumer(
                                      builder: (context, ref, child) {
                                        final settlementCollector = ref.watch(
                                            cashOperationsSelectedCustomerAccountCollectorProvider);

                                        final collectorsCollections = ref.watch(
                                            collectionsListStreamProvider);

                                        return collectorsCollections.when(
                                          data: (data) {
                                            // store the collector collection
                                            // that have the same date whith the
                                            // selected settlement date
                                            final collectorCollection =
                                                data.firstWhere(
                                              (collection) =>
                                                  collection.collectorId ==
                                                      settlementCollector!
                                                          .id! &&
                                                  collection.collectedAt.year ==
                                                      settlementCollectionDate
                                                          .year &&
                                                  collection
                                                          .collectedAt.month ==
                                                      settlementCollectionDate
                                                          .month &&
                                                  collection.collectedAt.day ==
                                                      settlementCollectionDate
                                                          .day,
                                              orElse: () => Collection(
                                                collectorId:
                                                    settlementCollector!.id!,
                                                amount: 0,
                                                rest: 0,
                                                agentId: 0,
                                                collectedAt:
                                                    settlementCollectionDate,
                                                createdAt: DateTime.now(),
                                                updatedAt: DateTime.now(),
                                              ),
                                            );
                                            return CBText(
                                              text:
                                                  '${collectorCollection.rest.ceil().toString()}f',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            );
                                          },
                                          error: (error, stackTrace) =>
                                              const CBText(text: ''),
                                          loading: () => const CBText(text: ''),
                                        );
                                      },
                                    )
                                  : const CBText(text: ''),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    child: CBIconButton(
                      onTap: () {},
                      icon: Icons.add_circle,
                      text: 'Ajouter un carte',
                    ),
                  ),
                  StaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                    children:
                        cashOperationsSelectedCustomerAccount.customerCardsIds
                            .map(
                              (customerCardId) => customersCardsListStream.when(
                                data: (data) {
                                  final realTimeCustomerCard = data.firstWhere(
                                    (customerCard) =>
                                        customerCard.id == customerCardId,
                                    orElse: () => CustomerCard(
                                      label: 'Undefined',
                                      typeId: 0,
                                      typeNumber: 0,
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                    ),
                                  );
                                  return CustomerCardSettlementCard(
                                    customerCard: realTimeCustomerCard,
                                  );
                                },
                                error: (error, stackTrace) => const SizedBox(),
                                loading: () => const SizedBox(),
                              ),
                            )
                            .toList(),
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

class CustomerCardSettlementCard extends StatefulHookConsumerWidget {
  final CustomerCard customerCard;
  const CustomerCardSettlementCard({
    super.key,
    required this.customerCard,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerCardSettlementCardState();
}

class _CustomerCardSettlementCardState
    extends ConsumerState<CustomerCardSettlementCard> {
  @override
  Widget build(BuildContext context) {
    final showForm = useState<bool>(true);
    final cashOperationsSelectedCustomerAccountOwnerCustomerCards = ref
        .watch(cashOperationsSelectedCustomerAccountOwnerCustomerCardsProvider);
    final typesListStream = ref.watch(typesListStreamProvider);
    return showForm.value
        ? SizedBox(
            width: 500,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomerCardWidget(
                        customerCard: widget.customerCard,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 100.0,
                        ),
                        child: CBFormTypeDropdown(
                          label: 'Type',
                          providerName: '',
                          dropdownMenuEntriesLabels: typesListStream.when(
                            data: (data) => data
                                .where(
                                  (type) =>
                                      cashOperationsSelectedCustomerAccountOwnerCustomerCards
                                          .any(
                                    (customerCard) =>
                                        customerCard.typeId == type.id,
                                  ),
                                )
                                .toList(),
                            error: (errror, stackTrace) => [],
                            loading: () => [],
                          ),
                          dropdownMenuEntriesValues: typesListStream.when(
                            data: (data) => data
                                .where(
                                  (type) =>
                                      cashOperationsSelectedCustomerAccountOwnerCustomerCards
                                          .any(
                                    (customerCard) =>
                                        customerCard.typeId == type.id,
                                  ),
                                )
                                .toList(),
                            error: (errror, stackTrace) => [],
                            loading: () => [],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showForm.value = !showForm.value;
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 30.0,
                          color: CBColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      width: 500,
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
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 5.0,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CBText(
                            text: 'Montant: ',
                            fontSize: 12,
                          ),
                          CBText(
                            text: '0f',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        : const SizedBox();
  }
}

class CustomerCardWidget extends ConsumerWidget {
  final CustomerCard customerCard;
  const CustomerCardWidget({
    super.key,
    required this.customerCard,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 7.0,
      color: CBColors.primaryColor,
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
                          cashOperationsSelectedCustomerAccountOwnerSelectedCard
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
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                );
              },
              error: (error, stackTrace) => CBText(
                text: customerCard.label,

                // sidebarSubOptionData.name
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              loading: () => const CBText(
                text: '',

                // sidebarSubOptionData.name
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
