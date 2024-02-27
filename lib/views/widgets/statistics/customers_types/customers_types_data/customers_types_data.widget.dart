import 'package:communitybank/controllers/customers_types/customers_types.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/customers_types/customers_types.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_account/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/type/type_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/date_symbol_data_local.dart';
//import 'package:intl/intl.dart';

final customersTypesStatisticsDataStreamProvider =
    StreamProvider<List<CustomersTypes>>((ref) async* {
  final selectedCustomerAccount = ref.watch(
    listCustomerAccountDropdownProvider(
        'customers-types-statistics-customer-account'),
  );
  final selectedType = ref.watch(
    listTypeDropdownProvider('customers-types-statistics-type'),
  );

  yield* CustomersTypesController.getCustomersTypes(
    customerAccountId: selectedCustomerAccount.id,
    typeId: selectedType.id == 0 ? null : selectedType.id,
  ).asStream();
});

class CustomersTypesStatisticsData extends ConsumerStatefulWidget {
  const CustomersTypesStatisticsData({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomersTypesStatisticsDataState();
}

class _CustomersTypesStatisticsDataState
    extends ConsumerState<CustomersTypesStatisticsData> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final customersTypesStatisticsDataStream =
        ref.watch(customersTypesStatisticsDataStreamProvider);

    //  final format = DateFormat.yMMMMEEEEd('fr');

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: customersTypesStatisticsDataStream.when(
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
                width: 100.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const SizedBox(),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Types',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 1000.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Clients',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
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
              final customersTypes = data[index];
              return Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 100.0,
                    height: 30.0,
                    child: const Icon(
                      Icons.aspect_ratio,
                      color: CBColors.primaryColor,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 300.0,
                    height: 30.0,
                    child: CBText(
                      text: customersTypes.typeName,
                      fontSize: 12.0,
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final customersNames = customersTypes.customersNames;
                      final customersFirstnames =
                          customersTypes.customersFirstnames;
                      String customers = '';

                      for (int i = 0; i < customersNames.length; ++i) {
                        if (customers.isEmpty &&
                            customersNames[i] != null &&
                            customersFirstnames[i] != null) {
                          customers =
                              '${customersNames[i]} ${customersFirstnames[i]}';
                        } else if (customersNames[i] != null &&
                            customersFirstnames[i] != null) {
                          customers =
                              '$customers, ${customersNames[i]} ${customersFirstnames[i]}';
                        }
                      }
                      return Container(
                        alignment: Alignment.centerLeft,
                        width: 1000.0,
                        height: 30.0,
                        child: CBText(
                          text: FunctionsController.truncateText(
                            text: customers,
                            maxLength: 110,
                          ),
                          fontSize: 12.0,
                        ),
                      );
                    },
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
                width: 100.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const SizedBox(),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Types',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 1000.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Clients',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
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
                width: 100.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const SizedBox(),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Types',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 1000.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Clients',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
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
