import 'package:communitybank/controllers/forms/validators/customer/customer.validator.dart';
import 'package:communitybank/controllers/forms/validators/customer_account/customer_account.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/collections/collections_crud.function.dart';
import 'package:communitybank/functions/crud/customers/customers_crud.function.dart';
import 'package:communitybank/functions/crud/customers_accounts/customers_accounts_crud.fuction.dart';
import 'package:communitybank/functions/crud/customers_categories/customers_categories_crud.function.dart';
import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/data/customers_category/customers_category.model.dart';
import 'package:communitybank/models/data/economical_activity/economical_activity.model.dart';
import 'package:communitybank/models/data/locality/locality.model.dart';
import 'package:communitybank/models/data/personal_status/personal_status.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/agents/agents_list/agents_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/collections/collections_list/collections_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/collectors/collectors_list/collectors_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers/customers_list/customers_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_accounts/customers_accounts_list/customers_accounts_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards_list/customers_cards_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_categories/customers_categories_list/customers_categories_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/economical_activities/economical_activities_list/economical_activities_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/localities/localities_list/localities_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/personal_status/personal_status_list/personal_status_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/collections/collections_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/customers/customers_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/customers_accounts/customers_accounts_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/customers_categories/customers_categories_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/collections/collection_amount/collections_amount_update_form.widget.dart';
import 'package:communitybank/views/widgets/forms/update/collections/collections_update_form.widget.dart';
import 'package:communitybank/views/widgets/forms/update/customer_account/customer_account_update_form.widget.dart';
import 'package:communitybank/views/widgets/forms/update/customers/customers_update_form.widget.dart';
import 'package:communitybank/views/widgets/forms/update/customers_categories/customers_categories_update_form.widget.dart';
import 'package:communitybank/views/widgets/globals/images_shower/single/single_image_shower.widget.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

final settlementsCollectionDateProvider = StateProvider<DateTime?>((ref) {
  return;
});

class WidgetTest extends StatefulHookConsumerWidget {
  const WidgetTest({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WidgetTestState();
}

class _WidgetTestState extends ConsumerState<WidgetTest> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  dynamic data;

  @override
  Widget build(BuildContext context) {
    //  final heigth = MediaQuery.of(context).size.height;
    //  final width = MediaQuery.of(context).size.width;

    return const Scaffold(
      body: SizedBox(
        //width: double.infinity,
        child: ProductsTable(),
      ),
    );
  }
}

class ProductsTable extends ConsumerStatefulWidget {
  const ProductsTable({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsTableState();
}

class _ProductsTableState extends ConsumerState<ProductsTable> {
  @override
  Widget build(BuildContext context) {
    final collectionsListStream = ref.watch(collectionsListStreamProvider);

    final format = DateFormat.yMMMMEEEEd('fr');

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: collectionsListStream.when(
          data: (data) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: MediaQuery.of(context).size.width,
            itemCount: data.length,
            isFixedHeader: true,
            leftHandSideColBackgroundColor: CBColors.backgroundColor,
            rightHandSideColBackgroundColor: CBColors.backgroundColor,
            headerWidgets: [
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'N°',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 500.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Chargé de compte',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Montant',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Reste',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 500.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Date de collecte',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 500.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Date de saisie',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 500.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Agent',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
            ],
            leftSideItemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                width: 200.0,
                height: 30.0,
                child: CBText(
                  text: '${index + 1}',
                  fontSize: 12.0,
                ),
              );
            },
            rightSideItemBuilder: (BuildContext context, int index) {
              final collection = data[index];
              return Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 500.0,
                    height: 30.0,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final collectorsListStream =
                            ref.watch(collectorsListStreamProvider);
                        return CBText(
                          text: collectorsListStream.when(
                              data: (data) {
                                final collector = data.firstWhere(
                                  (collector) =>
                                      collector.id == collection.collectorId,
                                );

                                return '${collector.name} ${collector.firstnames}';
                              },
                              error: ((error, stackTrace) => ''),
                              loading: () => ''),
                          fontSize: 12.0,
                        );
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: CBText(
                      text: collection.amount.ceil().toString(),
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: CBText(
                      text: collection.rest.ceil().toString(),
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 500.0,
                    height: 30.0,
                    child: CBText(
                      text:
                          '${format.format(collection.collectedAt)}  ${collection.collectedAt.hour}:${collection.collectedAt.minute}',
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 500.0,
                    height: 30.0,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final agentsListStream =
                            ref.watch(agentsListStreamProvider);

                        return CBText(
                          text: agentsListStream.when(
                              data: (data) {
                                final agent = data.firstWhere(
                                  (agent) => agent.id == collection.agentId,
                                );

                                return '${agent.name} ${agent.firstnames}';
                              },
                              error: ((error, stackTrace) => ''),
                              loading: () => ''),
                          fontSize: 12.0,
                        );
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 500.0,
                    height: 30.0,
                    child: CBText(
                      text:
                          '${format.format(collection.createdAt)}  ${collection.createdAt.hour}:${collection.createdAt.minute}',
                      fontSize: 12.0,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: CollectionAmountUpdateForm(
                          collection: collection,
                        ),
                      );
                    },
                    child: Container(
                      width: 150.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.add,
                        color: Colors.green[500],
                      ),
                    ),
                    // showEditIcon: true,
                  ),
                  InkWell(
                    onTap: () async {
                      FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: CollectionUpdateForm(
                          collection: collection,
                        ),
                      );
                    },
                    child: Container(
                      width: 150.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.edit,
                        color: Colors.green[500],
                      ),
                    ),
                    // showEditIcon: true,
                  ),
                  InkWell(
                    onTap: () async {
                      FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: CollectionDeletionConfirmationDialog(
                          collection: collection,
                          confirmToDelete: CollectionCRUDFunctions.delete,
                        ),
                      );
                    },
                    child: Container(
                      width: 150.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.delete_sharp,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              );
            },
            rowSeparatorWidget: const Divider(),
            scrollPhysics: const BouncingScrollPhysics(),
            horizontalScrollPhysics: const BouncingScrollPhysics(),
          ),
          error: (error, stackTrace) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: 1450,
            itemCount: 0,
            isFixedHeader: true,
            leftHandSideColBackgroundColor: CBColors.backgroundColor,
            rightHandSideColBackgroundColor: CBColors.backgroundColor,
            headerWidgets: [
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'N°',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 500.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Chargé de compte',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Montant',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Reste',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 500.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Date de collecte',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 500.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Date de saisie',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 500.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Agent',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
            ],
            leftSideItemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                width: 200.0,
                height: 30.0,
                child: CBText(
                  text: '${index + 1}',
                  fontSize: 12.0,
                ),
              );
            },
            rightSideItemBuilder: (BuildContext context, int index) {
              return const Row(
                children: [],
              );
            },
            rowSeparatorWidget: const Divider(),
            scrollPhysics: const BouncingScrollPhysics(),
            horizontalScrollPhysics: const BouncingScrollPhysics(),
          ),
          loading: () => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: 1450,
            itemCount: 0,
            isFixedHeader: true,
            leftHandSideColBackgroundColor: CBColors.backgroundColor,
            rightHandSideColBackgroundColor: CBColors.backgroundColor,
            headerWidgets: [
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'N°',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 500.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Chargé de compte',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Montant',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Reste',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 500.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Date de collecte',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 500.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Date de saisie',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 500.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Agent',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
            ],
            leftSideItemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                width: 200.0,
                height: 30.0,
                child: CBText(
                  text: '${index + 1}',
                  fontSize: 12.0,
                ),
              );
            },
            rightSideItemBuilder: (BuildContext context, int index) {
              return const Row(
                children: [],
              );
            },
            rowSeparatorWidget: const Divider(),
            scrollPhysics: const BouncingScrollPhysics(),
            horizontalScrollPhysics: const BouncingScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
