import 'package:communitybank/controllers/stocks/stocks.controller.dart';
import 'package:communitybank/controllers/stocks_details/stocks_details.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/stocks/stock_crud.function.dart';
import 'package:communitybank/models/data/stock/stock.model.dart';
import 'package:communitybank/models/data/stock_detail/stock_detail.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/stock/input/input_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/stock/output/output_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/stock/input/input_update_form.widget.dart';
import 'package:communitybank/views/widgets/forms/update/stock/output/output_update_form.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/agent/agent_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_account/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/product/product_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/string_dropdown/string_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/type/type_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:communitybank/views/widgets/stocks/stocks_sort_options/stocks_sort_options.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

final stocksDetailsListStreamProvider =
    StreamProvider<List<StockDetail>>((ref) async* {
  final selectedProduct =
      ref.watch(listProductDropdownProvider('stocks-product'));
  final selectedCustomerAccount =
      ref.watch(listCustomerAccountDropdownProvider('stocks-product'));
  final selectedType = ref.watch(listTypeDropdownProvider('stocks-type'));
  final selectedAgent = ref.watch(listAgentDropdownProvider('stocks-agent'));
  final selectedStockOutputType =
      ref.watch(listStringDropdownProvider('stocks-output-type'));
  final selectedStockMovementDate = ref.watch(stockMovementDateProvider);
  yield* StocksDetailsController.getStocksDetails(
    productId: selectedProduct.id != 0 ? selectedProduct.id : null,
    agentId: selectedAgent.id != 0 ? selectedAgent.id : null,
    customerCardId: null,
    customerAccountId:
        selectedCustomerAccount.id != 0 ? selectedCustomerAccount.id : null,
    typeId: selectedType.id != 0 ? selectedType.id : null,
    stockType: selectedStockOutputType != '*' ? selectedStockOutputType : null,
    stockMovementDate: selectedStockMovementDate != null
        ? FunctionsController.getSQLFormatDate(
            dateTime: selectedStockMovementDate,
          )
        : null,
  ).asStream();
});

final stocksListStreamProvider = StreamProvider<List<Stock>>((ref) async* {
  yield* StocksController.getAll(
    selectedProductId: null,
  );
});

class StocksList extends StatefulHookConsumerWidget {
  const StocksList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StocksListState();
}

class _StocksListState extends ConsumerState<StocksList> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final stocksDetailsListStream = ref.watch(stocksDetailsListStreamProvider);

    final format = DateFormat.yMMMMEEEEd('fr');

    ref.listen(stocksListStreamProvider, (previous, next) {
      ref.invalidate(stocksDetailsListStreamProvider);
    });

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: stocksDetailsListStream.when(
          data: (data) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: MediaQuery.of(context).size.width + 932,
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
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Produit',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 250.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Quantité Initiale',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 250.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Quantité Entrée',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 250.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Quantité Sortie',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 250.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Quantité Stock',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Type Sortie',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Carte',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Agent',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Date Mouvement',
                  textAlign: TextAlign.center,
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
              final stockDetail = data[index];
              return Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: CBText(
                      text: stockDetail.product,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 250.0,
                    height: 30.0,
                    child: CBText(
                      text: stockDetail.initialQuantity.toString(),
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 250.0,
                    height: 30.0,
                    child: CBText(
                      text: stockDetail.inputedQuantity?.toString() ?? '0',
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 250.0,
                    height: 30.0,
                    child: CBText(
                      text: stockDetail.outputedQuantity?.toString() ?? '0',
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 250.0,
                    height: 30.0,
                    child: CBText(
                      text: stockDetail.stockQuantity.toString(),
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 200.0,
                    height: 30.0,
                    child: CBText(
                      text: stockDetail.type ?? '',
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: CBText(
                      text: stockDetail.customerCard ?? '',
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: CBText(
                      text: stockDetail.agent,
                      fontSize: 12.0,
                    ),
                  ),
                  Consumer(builder: (context, ref, child) {
                    final time = FunctionsController.getFormatedTime(
                      dateTime: stockDetail.createdAt,
                    );
                    return Container(
                      alignment: Alignment.centerLeft,
                      width: 300.0,
                      height: 30.0,
                      child: CBText(
                        text: '${format.format(stockDetail.createdAt)} $time',
                        fontSize: 12.0,
                      ),
                    );
                  }),
                  InkWell(
                    onTap: () {
                      if (stockDetail.inputedQuantity != 0) {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: StockInputUpdateForm(
                            stock: Stock(
                              id: stockDetail.stockId,
                              productId: stockDetail.productId,
                              initialQuantity: stockDetail.initialQuantity,
                              inputedQuantity: stockDetail.inputedQuantity,
                              stockQuantity: stockDetail.stockQuantity,
                              agentId: stockDetail.agentId,
                              createdAt: stockDetail.createdAt,
                              updatedAt: stockDetail.updatedAt,
                            ),
                          ),
                        );
                      } else if (stockDetail.outputedQuantity != 0 &&
                          stockDetail.type == StockOutputType.manual) {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: StockOutputUpdateForm(
                            stock: Stock(
                              id: stockDetail.stockId,
                              productId: stockDetail.productId,
                              initialQuantity: stockDetail.initialQuantity,
                              outputedQuantity: stockDetail.outputedQuantity,
                              type: stockDetail.type,
                              stockQuantity: stockDetail.stockQuantity,
                              agentId: stockDetail.agentId,
                              createdAt: stockDetail.createdAt,
                              updatedAt: stockDetail.updatedAt,
                            ),
                          ),
                        );
                      }
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
                      if (stockDetail.inputedQuantity != 0) {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: StockInputDeletionConfirmationDialog(
                            stock: Stock(
                              id: stockDetail.stockId,
                              productId: stockDetail.productId,
                              initialQuantity: stockDetail.initialQuantity,
                              inputedQuantity: stockDetail.inputedQuantity,
                              stockQuantity: stockDetail.stockQuantity,
                              agentId: stockDetail.agentId,
                              createdAt: stockDetail.createdAt,
                              updatedAt: stockDetail.updatedAt,
                            ),
                            confirmToDelete:
                                StockCRUDFunctions.deleteStockInput,
                          ),
                        );
                      } else if (stockDetail.outputedQuantity != 0 &&
                          stockDetail.type == StockOutputType.manual) {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: StockOutputDeletionConfirmationDialog(
                            stock: Stock(
                              id: stockDetail.stockId,
                              productId: stockDetail.productId,
                              initialQuantity: stockDetail.initialQuantity,
                              outputedQuantity: stockDetail.outputedQuantity,
                              type: stockDetail.type,
                              stockQuantity: stockDetail.stockQuantity,
                              agentId: stockDetail.agentId,
                              createdAt: stockDetail.createdAt,
                              updatedAt: stockDetail.updatedAt,
                            ),
                            confirmToDelete:
                                StockCRUDFunctions.deleteStockOutput,
                          ),
                        );
                      }
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
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Produit',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 250.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Quantité Initiale',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 250.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Quantité Entrée',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 250.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Quantité Sortie',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 250.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Quantité Stock',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Type Sortie',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Carte',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Agent',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Date Mouvement',
                  textAlign: TextAlign.center,
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
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Produit',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 250.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Quantité Initiale',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 250.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Quantité Entrée',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 250.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Quantité Sortie',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 250.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Quantité Stock',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Type Sortie',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Carte',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Agent',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Date Mouvement',
                  textAlign: TextAlign.center,
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
