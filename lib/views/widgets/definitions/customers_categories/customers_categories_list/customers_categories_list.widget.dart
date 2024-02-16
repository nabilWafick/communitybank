import 'package:communitybank/controllers/customers_categories/customers_categories.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/customers_categories/customers_categories_crud.function.dart';
import 'package:communitybank/models/data/customers_category/customers_category.model.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/customers_categories/customers_categories_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/customers_categories/customers_categories_update_form.widget.dart';
import 'package:communitybank/views/widgets/globals/search_input/search_input.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchedCustomersCategoriesListProvider =
    StreamProvider<List<CustomerCategory>>((ref) async* {
  String searchedCustomerCategory =
      ref.watch(searchProvider('customers-categories'));
  ref.listen(searchProvider('customers-categories'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('customers-categories').notifier).state =
          true;
    } else {
      ref.read(isSearchingProvider('customers-categories').notifier).state =
          false;
    }
  });
  yield* CustomersCategoriesController.searchCustomerCategory(
          name: searchedCustomerCategory)
      .asStream();
});

final custumersCategoriesListStreamProvider =
    StreamProvider<List<CustomerCategory>>((ref) async* {
  yield* CustomersCategoriesController.getAll();
});

class CustomersCategoriesList extends ConsumerWidget {
  const CustomersCategoriesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearching = ref.watch(isSearchingProvider('customers-categories'));
    final customersCategoriesListStream =
        ref.watch(custumersCategoriesListStreamProvider);
    final searchedCustomersCategoriesList =
        ref.watch(searchedCustomersCategoriesListProvider);

    return SizedBox(
      height: 600.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            showCheckboxColumn: true,
            columns: [
              const DataColumn(
                label: CBText(
                  text: 'Code',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              DataColumn(
                label: CBSearchInput(
                  hintText: 'Nom',
                  searchProvider: searchProvider('customers-categories'),
                ),
                /* CBText(
                  text: 'Nom',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),*/
              ),
              const DataColumn(
                label: SizedBox(),
              ),
              const DataColumn(
                label: SizedBox(),
              ),
            ],
            rows: isSearching
                ? searchedCustomersCategoriesList.when(
                    data: (data) {
                      //  debugPrint('customerCategory Stream Data: $data');
                      return data
                          .map(
                            (customerCategory) => DataRow(
                              cells: [
                                DataCell(
                                  CBText(
                                    text:
                                        '${data.indexOf(customerCategory) + 1}',
                                    fontSize: 12.0,
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customerCategory.name,
                                    fontSize: 12.0,
                                  ),
                                ),
                                DataCell(
                                  onTap: () {
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: CustomerCategoryUpdateForm(
                                          customerCategory: customerCategory),
                                    );
                                  },
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    ),
                                  ),
                                  // showEditIcon: true,
                                ),
                                DataCell(
                                  onTap: () async {
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog:
                                          CustomerCategoryDeletionConfirmationDialog(
                                        customerCategory: customerCategory,
                                        confirmToDelete:
                                            CustomerCategoryCRUDFunctions
                                                .delete,
                                      ),
                                    );
                                  },
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: const Icon(
                                      Icons.delete_sharp,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList();
                    },
                    error: (error, stack) {
                      //  debugPrint('customerCategorys Stream Error');
                      return [];
                    },
                    loading: () {
                      //  debugPrint('customerCategorys Stream Loading');
                      return [];
                    },
                  )
                : customersCategoriesListStream.when(
                    data: (data) {
                      //  debugPrint('customerCategory Stream Data: $data');
                      return data
                          .map(
                            (customerCategory) => DataRow(
                              cells: [
                                DataCell(
                                  CBText(
                                    text:
                                        '${data.indexOf(customerCategory) + 1}',
                                    fontSize: 12.0,
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customerCategory.name,
                                    fontSize: 12.0,
                                  ),
                                ),
                                DataCell(
                                  onTap: () {
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: CustomerCategoryUpdateForm(
                                          customerCategory: customerCategory),
                                    );
                                  },
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    ),
                                  ),
                                  // showEditIcon: true,
                                ),
                                DataCell(
                                  onTap: () async {
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog:
                                          CustomerCategoryDeletionConfirmationDialog(
                                        customerCategory: customerCategory,
                                        confirmToDelete:
                                            CustomerCategoryCRUDFunctions
                                                .delete,
                                      ),
                                    );
                                  },
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: const Icon(
                                      Icons.delete_sharp,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList();
                    },
                    error: (error, stack) {
                      //  debugPrint('customerCategorys Stream Error');
                      return [];
                    },
                    loading: () {
                      //  debugPrint('customerCategorys Stream Loading');
                      return [];
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
