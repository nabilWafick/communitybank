import 'package:communitybank/controllers/customers/customers.controller.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_category_dropdown/customer_category_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/economical_activity_dropdown/economical_activity_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/locality_dropdown/locality_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/personal_status_dropdown/personal_status_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchedCustomersListProvider =
    StreamProvider<List<Customer>>((ref) async* {
  String searchedCustomer = ref.watch(searchProvider('customers'));
  ref.listen(searchProvider('customers'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('customers').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('customers').notifier).state = false;
    }
  });
  yield* CustomersController.searchCustomer(name: searchedCustomer).asStream();
});

final customersListStreamProvider =
    StreamProvider<List<Customer>>((ref) async* {
  final selectedCustomerEconomicalActivity = ref.watch(
      listEconomicalActivityDropdownProvider(
          'customer-list-sort-economical-activity'));
  final selectedCustomerCategory = ref.watch(
      listCustomerCategoryDropdownProvider('customer-list-sort-category'));
  final selectedCustomerPersonalStatus = ref.watch(
      listPersonalStatusDropdownProvider('customer-list-sort-personal-status'));
  final selectedCustomerLocality =
      ref.watch(listLocalityDropdownProvider('customer-list-sort-locality'));
  yield* CustomersController.getAll(
    selectedCustomerCategoryId: selectedCustomerCategory.id,
    selectedCustomerEconomicalActivityId: selectedCustomerEconomicalActivity.id,
    selectedCustomerLocalityId: selectedCustomerLocality.id,
    selectedCustomerPersonalStatusId: selectedCustomerPersonalStatus.id,
  );
});

class CustomersList extends ConsumerWidget {
  const CustomersList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customersListStream = ref.watch(customersListStreamProvider);
    //  final searchedCustomers = ref.watch(searchedCustomersListProvider);
    return SizedBox(
      height: 640.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            showCheckboxColumn: true,
            columns: const [
              DataColumn(
                label: CBText(
                  text: 'Code',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Photo',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Nom & Prénoms',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Téléphone',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Adresse',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Profession',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Numéro CNI',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Catégorie',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Activité économique',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Status Personnel',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Localité',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Signature',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: SizedBox(),
              ),
              DataColumn(
                label: SizedBox(),
              ),
            ],
            rows: customersListStream.when(
              data: (data) {
                //  debugPrint('customers: $data');
                return data
                    .map(
                      (customer) => DataRow(
                        cells: [
                          DataCell(
                            CBText(text: customer.id!.toString()),
                          ),
                          DataCell(customer.profile != null
                              ? Container(
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.account_circle_sharp,
                                    size: 35.0,
                                    color: CBColors.primaryColor,
                                  ),
                                )
                              : const SizedBox()),
                          DataCell(
                            CBText(
                                text:
                                    '${customer.firstnames} ${customer.name}'),
                          ),
                          DataCell(
                            CBText(text: customer.phoneNumber),
                          ),
                          DataCell(
                            CBText(text: customer.address),
                          ),
                          DataCell(
                            CBText(
                              text: customer.profession,
                            ),
                          ),
                          DataCell(
                            CBText(
                              text: customer.nicNumber.toString(),
                            ),
                          ),
                          DataCell(
                            CBText(
                              text: customer.category.name,
                            ),
                          ),
                          DataCell(
                            CBText(
                              text: customer.economicalActivity.name,
                            ),
                          ),
                          DataCell(
                            CBText(
                              text: customer.personalStatus.name,
                            ),
                          ),
                          DataCell(
                            CBText(
                              text: customer.locality.name,
                            ),
                          ),
                          DataCell(customer.profile != null
                              ? Container(
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.photo,
                                    color: CBColors.primaryColor,
                                  ),
                                )
                              : const SizedBox()),
                          DataCell(
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
              error: (error, stackTrace) => [],
              loading: () => [],
            ),
          ),
        ),
      ),
    );
  }
}
