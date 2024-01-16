import 'package:communitybank/controllers/customers/customers.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/customers/customers_crud.function.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/definitions/customers_categories/customers_categories_list/customers_categories_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/economical_activities/economical_activities_list/economical_activities_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/images_shower/single/single_image_shower.widget.dart';
import 'package:communitybank/views/widgets/definitions/localities/localities_list/localities_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/personal_status/personal_status_list/personal_status_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/customers/customers_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/customers/customers_update_form.widget.dart';
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
    final isSearching = ref.watch(isSearchingProvider('customers'));
    final customersListStream = ref.watch(customersListStreamProvider);
    final searchedCustomers = ref.watch(searchedCustomersListProvider);
    final economicalActivitiesListStream =
        ref.watch(economicalActivityListStreamProvider);
    final customersCategoriesListStream =
        ref.watch(custumersCategoriesListStreamProvider);
    final localitiesListStream = ref.watch(localityListStreamProvider);
    final personalStatusListStream =
        ref.watch(personalStatusListStreamProvider);
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
            rows: isSearching
                ? searchedCustomers.when(
                    data: (data) {
                      return data
                          .map(
                            (customer) => DataRow(
                              cells: [
                                DataCell(
                                  CBText(text: customer.id!.toString()),
                                ),
                                DataCell(
                                  onTap: () {
                                    customer.profile != null
                                        ? FunctionsController.showAlertDialog(
                                            context: context,
                                            alertDialog: SingleImageShower(
                                              imageSource: customer.profile!,
                                            ),
                                          )
                                        : () {};
                                  },
                                  customer.profile != null
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.account_circle_sharp,
                                            size: 35.0,
                                            color: CBColors.primaryColor,
                                          ),
                                        )
                                      : const SizedBox(),
                                ),
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
                                    text: customer.categoryId == null
                                        ? 'Non définie'
                                        : customersCategoriesListStream.when(
                                            data: (data) {
                                              return data
                                                  .firstWhere((category) {
                                                return category.id ==
                                                    customer.categoryId;
                                              }).name;
                                            },
                                            error: (error, stackTrace) => '',
                                            loading: () => '',
                                          ),
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customer.economicalActivityId == null
                                        ? 'Non définie'
                                        : economicalActivitiesListStream.when(
                                            data: (data) {
                                              return data.firstWhere(
                                                  (conomicalActivity) {
                                                return conomicalActivity.id ==
                                                    customer
                                                        .economicalActivityId;
                                              }).name;
                                            },
                                            error: (error, stackTrace) => '',
                                            loading: () => '',
                                          ),
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customer.personalStatusId == null
                                        ? 'Non défini'
                                        : personalStatusListStream.when(
                                            data: (data) => data
                                                .firstWhere((personalStatus) =>
                                                    customer.personalStatusId ==
                                                    personalStatus.id)
                                                .name,
                                            error: (error, stackTrace) => '',
                                            loading: () => '',
                                          ),
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customer.localityId == null
                                        ? 'Non définie'
                                        : localitiesListStream.when(
                                            data: (data) => data
                                                .firstWhere((locality) =>
                                                    locality.id ==
                                                    customer.localityId)
                                                .name,
                                            error: (error, stackTrace) => '',
                                            loading: () => '',
                                          ),
                                  ),
                                ),
                                DataCell(
                                  onTap: () {
                                    customer.signature != null
                                        ? FunctionsController.showAlertDialog(
                                            context: context,
                                            alertDialog: SingleImageShower(
                                              imageSource: customer.signature!,
                                            ),
                                          )
                                        : () {};
                                  },
                                  customer.signature != null
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.photo,
                                            color: CBColors.primaryColor,
                                          ),
                                        )
                                      : const SizedBox(),
                                ),
                                DataCell(
                                  onTap: () {
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: CustomerUpdateForm(
                                          customer: customer),
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
                                  onTap: () {
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog:
                                          CustomerDeletionConfirmationDialog(
                                        customer: customer,
                                        confirmToDelete:
                                            CustomerCRUDFunctions.delete,
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
                    error: (error, stackTrace) => [],
                    loading: () => [],
                  )
                : customersListStream.when(
                    data: (data) {
                      return data
                          .map(
                            (customer) => DataRow(
                              cells: [
                                DataCell(
                                  CBText(text: customer.id!.toString()),
                                ),
                                DataCell(
                                  onTap: () {
                                    customer.profile != null
                                        ? FunctionsController.showAlertDialog(
                                            context: context,
                                            alertDialog: SingleImageShower(
                                              imageSource: customer.profile!,
                                            ),
                                          )
                                        : () {};
                                  },
                                  customer.profile != null
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.account_circle_sharp,
                                            size: 35.0,
                                            color: CBColors.primaryColor,
                                          ),
                                        )
                                      : const SizedBox(),
                                ),
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
                                    text: customer.categoryId == null
                                        ? 'Non définie'
                                        : customersCategoriesListStream.when(
                                            data: (data) {
                                              return data
                                                  .firstWhere((category) {
                                                return category.id ==
                                                    customer.categoryId;
                                              }).name;
                                            },
                                            error: (error, stackTrace) => '',
                                            loading: () => '',
                                          ),
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customer.economicalActivityId == null
                                        ? 'Non définie'
                                        : economicalActivitiesListStream.when(
                                            data: (data) {
                                              return data.firstWhere(
                                                  (conomicalActivity) {
                                                return conomicalActivity.id ==
                                                    customer
                                                        .economicalActivityId;
                                              }).name;
                                            },
                                            error: (error, stackTrace) => '',
                                            loading: () => '',
                                          ),
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customer.personalStatusId == null
                                        ? 'Non défini'
                                        : personalStatusListStream.when(
                                            data: (data) => data
                                                .firstWhere((personalStatus) =>
                                                    customer.personalStatusId ==
                                                    personalStatus.id)
                                                .name,
                                            error: (error, stackTrace) => '',
                                            loading: () => '',
                                          ),
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customer.localityId == null
                                        ? 'Non définie'
                                        : localitiesListStream.when(
                                            data: (data) => data
                                                .firstWhere((locality) =>
                                                    locality.id ==
                                                    customer.localityId)
                                                .name,
                                            error: (error, stackTrace) => '',
                                            loading: () => '',
                                          ),
                                  ),
                                ),
                                DataCell(
                                  onTap: () {
                                    customer.signature != null
                                        ? FunctionsController.showAlertDialog(
                                            context: context,
                                            alertDialog: SingleImageShower(
                                              imageSource: customer.signature!,
                                            ),
                                          )
                                        : () {};
                                  },
                                  customer.signature != null
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.photo,
                                            color: CBColors.primaryColor,
                                          ),
                                        )
                                      : const SizedBox(),
                                ),
                                DataCell(
                                  onTap: () {
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: CustomerUpdateForm(
                                          customer: customer),
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
                                  onTap: () {
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog:
                                          CustomerDeletionConfirmationDialog(
                                        customer: customer,
                                        confirmToDelete:
                                            CustomerCRUDFunctions.delete,
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
                    error: (error, stackTrace) => [],
                    loading: () => [],
                  ),
          ),
        ),
      ),
    );
  }
}
