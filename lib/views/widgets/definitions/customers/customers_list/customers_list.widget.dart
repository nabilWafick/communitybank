import 'package:communitybank/controllers/customers/customers.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/customers/customers_crud.function.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/models/data/economical_activity/economical_activity.model.dart';
import 'package:communitybank/models/data/locality/locality.model.dart';
import 'package:communitybank/models/data/personal_status/personal_status.model.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/definitions/customers_categories/customers_categories_list/customers_categories_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/economical_activities/economical_activities_list/economical_activities_list.widget.dart';
import 'package:communitybank/views/widgets/globals/images_shower/single/single_image_shower.widget.dart';
import 'package:communitybank/views/widgets/definitions/localities/localities_list/localities_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/personal_status/personal_status_list/personal_status_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/customers/customers_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/customers/customers_update_form.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_category/customer_category_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/economical_activity/economical_activity_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/locality/locality_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/personal_status/personal_status_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:communitybank/models/data/customers_category/customers_category.model.dart';

final searchedCustomersListProvider =
    StreamProvider<List<Customer>>((ref) async* {
  // customer name
  String searchedCustomerName = ref.watch(searchProvider('customers-name'));
  ref.listen(searchProvider('customers-name'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('customers-name').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('customers-name').notifier).state = false;
    }
  });

  // customer firstnames
  String searchedCustomerFirstnames =
      ref.watch(searchProvider('customers-firstnames'));
  ref.listen(searchProvider('customers-firstnames'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('customers-firstnames').notifier).state =
          true;
    } else {
      ref.read(isSearchingProvider('customers-firstnames').notifier).state =
          false;
    }
  });

  // customer phoneNumber
  String searchedCustomerPhoneNumber =
      ref.watch(searchProvider('customers-phoneNumber'));
  ref.listen(searchProvider('customers-phoneNumber'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('customers-phoneNumber').notifier).state =
          true;
    } else {
      ref.read(isSearchingProvider('customers-phoneNumber').notifier).state =
          false;
    }
  });

  // customer address
  String searchedCustomerAddress =
      ref.watch(searchProvider('customers-address'));
  ref.listen(searchProvider('customers-address'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('customers-address').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('customers-address').notifier).state = false;
    }
  });

  // customer profession
  String searchedCustomerProfession =
      ref.watch(searchProvider('customers-profession'));
  ref.listen(searchProvider('customers-profession'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('customers-profession').notifier).state =
          true;
    } else {
      ref.read(isSearchingProvider('customers-profession').notifier).state =
          false;
    }
  });

  // customer nicNumber
  String searchedCustomerNicNumber =
      ref.watch(searchProvider('customers-nicNumber'));
  ref.listen(searchProvider('customers-nicNumber'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('customers-nicNumber').notifier).state =
          true;
    } else {
      ref.read(isSearchingProvider('customers-nicNumber').notifier).state =
          false;
    }
  });

  yield* CustomersController.searchCustomer(
    searchedCustomerName: searchedCustomerName,
    searchedCustomerFirstnames: searchedCustomerFirstnames,
    searchedCustomerPhoneNumber: searchedCustomerPhoneNumber,
    searchedCustomerAddress: searchedCustomerAddress,
    searchedCustomerProfession: searchedCustomerProfession,
    searchedCustomerNicNumber: searchedCustomerNicNumber,
  ).asStream();
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
    selectedCustomerCategoryId: selectedCustomerCategory.id!,
    selectedCustomerEconomicalActivityId:
        selectedCustomerEconomicalActivity.id!,
    selectedCustomerLocalityId: selectedCustomerLocality.id!,
    selectedCustomerPersonalStatusId: selectedCustomerPersonalStatus.id!,
  );
});

class CustomersList extends ConsumerStatefulWidget {
  const CustomersList({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomersListState();
}

class _CustomersListState extends ConsumerState<CustomersList> {
  final ScrollController horizontallScrollController = ScrollController();
  final ScrollController verticalScrollController = ScrollController();

  @override
  Widget build(
    BuildContext context,
  ) {
    final isSearching = ref.watch(isSearchingProvider('customers-name')) ||
        ref.watch(isSearchingProvider('customers-firstnames')) ||
        ref.watch(isSearchingProvider('customers-phoneNumber')) ||
        ref.watch(isSearchingProvider('customers-address')) ||
        ref.watch(isSearchingProvider('customers-profession')) ||
        ref.watch(isSearchingProvider('customers-nicNumber'));
    final customersListStream = ref.watch(customersListStreamProvider);
    final searchedCustomers = ref.watch(searchedCustomersListProvider);

    return SizedBox(
      height: 600.0,
      child: Scrollbar(
        controller: horizontallScrollController,
        child: SingleChildScrollView(
          controller: horizontallScrollController,
          scrollDirection: Axis.horizontal,
          child: Scrollbar(
            controller: verticalScrollController,
            child: SingleChildScrollView(
              controller: verticalScrollController,
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
                  const DataColumn(
                    label: CBText(
                      text: 'Photo',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  DataColumn(
                      label: CBSearchInput(
                    hintText: 'Nom',
                    searchProvider: searchProvider('customers-name'),
                  )
                      /*  CBText(
                      text: 'Nom',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                 */
                      ),
                  DataColumn(
                      label: CBSearchInput(
                    hintText: 'Prénoms',
                    searchProvider: searchProvider('customers-firstnames'),
                  )
                      /* CBText(
                      text: 'Prénoms',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),*/
                      ),
                  DataColumn(
                      label: CBSearchInput(
                    hintText: 'Téléphone',
                    searchProvider: searchProvider('customers-phoneNumber'),
                  )
                      /* CBText(
                      text: 'Téléphone',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),*/
                      ),
                  DataColumn(
                      label: CBSearchInput(
                    hintText: 'Adresse',
                    searchProvider: searchProvider('customers-address'),
                  )
                      /* CBText(
                      text: 'Adresse',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),*/
                      ),
                  DataColumn(
                      label: CBSearchInput(
                    hintText: 'Profession',
                    searchProvider: searchProvider('customers-profession'),
                  )
                      /*CBText(
                      text: 'Profession',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                    */
                      ),
                  DataColumn(
                      label: CBSearchInput(
                    hintText: 'Numero CNI',
                    searchProvider: searchProvider('customers-nicNumber'),
                  )
                      /* label: CBText(
                      text: 'Numéro CNI',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),*/
                      ),
                  const DataColumn(
                    label: CBText(
                      text: 'Catégorie',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const DataColumn(
                    label: CBText(
                      text: 'Activité économique',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const DataColumn(
                    label: CBText(
                      text: 'Status Personnel',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const DataColumn(
                    label: CBText(
                      text: 'Localité',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const DataColumn(
                    label: CBText(
                      text: 'Signature',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const DataColumn(
                    label: SizedBox(),
                  ),
                  const DataColumn(
                    label: SizedBox(),
                  ),
                ],
                rows: isSearching
                    ? searchedCustomers.when(
                        data: (data) {
                          return data.map(
                            (customer) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    CBText(
                                      text: '${data.indexOf(customer) + 1}',
                                      fontSize: 12.0,
                                    ),
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
                                      text: customer.name,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  DataCell(
                                    CBText(
                                      text: customer.firstnames,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  DataCell(
                                    CBText(
                                      text: customer.phoneNumber,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  DataCell(
                                    CBText(
                                      text: customer.address,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  DataCell(
                                    CBText(
                                      text: customer.profession ?? '',
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  DataCell(
                                    CBText(
                                      text:
                                          customer.nicNumber?.toString() ?? '',
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  DataCell(Consumer(
                                    builder: (BuildContext context,
                                        WidgetRef ref, Widget? child) {
                                      final customersCategoriesListStream =
                                          ref.watch(
                                              custumersCategoriesListStreamProvider);

                                      return customersCategoriesListStream.when(
                                        data: (data) {
                                          CustomerCategory customerCategory =
                                              CustomerCategory(
                                            name: 'Non définie',
                                            createdAt: DateTime.now(),
                                            updatedAt: DateTime.now(),
                                          );

                                          for (CustomerCategory customerCategoryData
                                              in data) {
                                            if (customerCategoryData.id ==
                                                customer.categoryId) {
                                              customerCategory =
                                                  customerCategoryData;
                                              break;
                                            }
                                          }

                                          return CBText(
                                            text: customerCategory.name,
                                            fontSize: 12.0,
                                          );
                                        },
                                        error: (error, stackTrace) =>
                                            const CBText(
                                          text: '',
                                        ),
                                        loading: () => const CBText(text: ''),
                                      );
                                    },
                                  )),
                                  DataCell(Consumer(
                                    builder: (BuildContext context,
                                        WidgetRef ref, Widget? child) {
                                      final economicalActivitiesListStream =
                                          ref.watch(
                                              economicalActivityListStreamProvider);

                                      return economicalActivitiesListStream
                                          .when(
                                        data: (data) {
                                          EconomicalActivity
                                              economicalActivity =
                                              EconomicalActivity(
                                            name: 'Non définie',
                                            createdAt: DateTime.now(),
                                            updatedAt: DateTime.now(),
                                          );

                                          for (EconomicalActivity economicalActivityData
                                              in data) {
                                            if (economicalActivityData.id ==
                                                customer.economicalActivityId) {
                                              economicalActivity =
                                                  economicalActivityData;
                                              break;
                                            }
                                          }

                                          return CBText(
                                            text: economicalActivity.name,
                                            fontSize: 12.0,
                                          );
                                        },
                                        error: (error, stackTrace) =>
                                            const CBText(
                                          text: '',
                                        ),
                                        loading: () => const CBText(text: ''),
                                      );
                                    },
                                  )),
                                  DataCell(Consumer(
                                    builder: (BuildContext context,
                                        WidgetRef ref, Widget? child) {
                                      final personalStatusListStream =
                                          ref.watch(
                                              personalStatusListStreamProvider);

                                      return personalStatusListStream.when(
                                        data: (data) {
                                          PersonalStatus personalStatus =
                                              PersonalStatus(
                                            name: 'Non défini',
                                            createdAt: DateTime.now(),
                                            updatedAt: DateTime.now(),
                                          );

                                          for (PersonalStatus personalStatusData
                                              in data) {
                                            if (personalStatusData.id ==
                                                customer.personalStatusId) {
                                              personalStatus =
                                                  personalStatusData;
                                              break;
                                            }
                                          }

                                          return CBText(
                                            text: personalStatus.name,
                                            fontSize: 12.0,
                                          );
                                        },
                                        error: (error, stackTrace) =>
                                            const CBText(
                                          text: '',
                                        ),
                                        loading: () => const CBText(text: ''),
                                      );
                                    },
                                  )),
                                  DataCell(Consumer(
                                    builder: (BuildContext context,
                                        WidgetRef ref, Widget? child) {
                                      final localitiesListStream =
                                          ref.watch(localityListStreamProvider);

                                      return localitiesListStream.when(
                                        data: (data) {
                                          Locality customerLocality = Locality(
                                            name: 'Non définie',
                                            createdAt: DateTime.now(),
                                            updatedAt: DateTime.now(),
                                          );

                                          for (Locality localityData in data) {
                                            if (localityData.id ==
                                                customer.localityId) {
                                              customerLocality = localityData;
                                              break;
                                            }
                                          }

                                          return CBText(
                                            text: customerLocality.name,
                                            fontSize: 12.0,
                                          );
                                        },
                                        error: (error, stackTrace) =>
                                            const CBText(
                                          text: '',
                                        ),
                                        loading: () => const CBText(text: ''),
                                      );
                                    },
                                  )),
                                  DataCell(
                                    onTap: () {
                                      customer.signature != null
                                          ? FunctionsController.showAlertDialog(
                                              context: context,
                                              alertDialog: SingleImageShower(
                                                imageSource:
                                                    customer.signature!,
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
                                    onTap: () async {
                                      await FunctionsController.showAlertDialog(
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
                              );
                            },
                          ).toList();
                        },
                        error: (error, stackTrace) => [],
                        loading: () => [],
                      )
                    : customersListStream.when(
                        data: (data) {
                          return data.map(
                            (customer) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    CBText(
                                      text: '${data.indexOf(customer) + 1}',
                                      fontSize: 12.0,
                                    ),
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
                                      text: customer.name,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  DataCell(
                                    CBText(
                                      text: customer.firstnames,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  DataCell(
                                    CBText(
                                      text: customer.phoneNumber,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  DataCell(
                                    CBText(
                                      text: customer.address,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  DataCell(
                                    CBText(
                                      text: customer.profession ?? '',
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  DataCell(
                                    CBText(
                                      text:
                                          customer.nicNumber?.toString() ?? '',
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  DataCell(Consumer(
                                    builder: (BuildContext context,
                                        WidgetRef ref, Widget? child) {
                                      final customersCategoriesListStream =
                                          ref.watch(
                                              custumersCategoriesListStreamProvider);

                                      return customersCategoriesListStream.when(
                                        data: (data) {
                                          CustomerCategory customerCategory =
                                              CustomerCategory(
                                            name: 'Non définie',
                                            createdAt: DateTime.now(),
                                            updatedAt: DateTime.now(),
                                          );

                                          for (CustomerCategory customerCategoryData
                                              in data) {
                                            if (customerCategoryData.id ==
                                                customer.categoryId) {
                                              customerCategory =
                                                  customerCategoryData;
                                              break;
                                            }
                                          }

                                          return CBText(
                                            text: customerCategory.name,
                                            fontSize: 12.0,
                                          );
                                        },
                                        error: (error, stackTrace) =>
                                            const CBText(
                                          text: '',
                                        ),
                                        loading: () => const CBText(text: ''),
                                      );
                                    },
                                  )),
                                  DataCell(Consumer(
                                    builder: (BuildContext context,
                                        WidgetRef ref, Widget? child) {
                                      final economicalActivitiesListStream =
                                          ref.watch(
                                              economicalActivityListStreamProvider);

                                      return economicalActivitiesListStream
                                          .when(
                                        data: (data) {
                                          EconomicalActivity
                                              economicalActivity =
                                              EconomicalActivity(
                                            name: 'Non définie',
                                            createdAt: DateTime.now(),
                                            updatedAt: DateTime.now(),
                                          );

                                          for (EconomicalActivity economicalActivityData
                                              in data) {
                                            if (economicalActivityData.id ==
                                                customer.economicalActivityId) {
                                              economicalActivity =
                                                  economicalActivityData;
                                              break;
                                            }
                                          }

                                          return CBText(
                                            text: economicalActivity.name,
                                            fontSize: 12.0,
                                          );
                                        },
                                        error: (error, stackTrace) =>
                                            const CBText(
                                          text: '',
                                        ),
                                        loading: () => const CBText(text: ''),
                                      );
                                    },
                                  )),
                                  DataCell(Consumer(
                                    builder: (BuildContext context,
                                        WidgetRef ref, Widget? child) {
                                      final personalStatusListStream =
                                          ref.watch(
                                              personalStatusListStreamProvider);

                                      return personalStatusListStream.when(
                                        data: (data) {
                                          PersonalStatus personalStatus =
                                              PersonalStatus(
                                            name: 'Non défini',
                                            createdAt: DateTime.now(),
                                            updatedAt: DateTime.now(),
                                          );

                                          for (PersonalStatus personalStatusData
                                              in data) {
                                            if (personalStatusData.id ==
                                                customer.personalStatusId) {
                                              personalStatus =
                                                  personalStatusData;
                                              break;
                                            }
                                          }

                                          return CBText(
                                            text: personalStatus.name,
                                            fontSize: 12.0,
                                          );
                                        },
                                        error: (error, stackTrace) =>
                                            const CBText(
                                          text: '',
                                        ),
                                        loading: () => const CBText(text: ''),
                                      );
                                    },
                                  )),
                                  DataCell(Consumer(
                                    builder: (BuildContext context,
                                        WidgetRef ref, Widget? child) {
                                      final localitiesListStream =
                                          ref.watch(localityListStreamProvider);

                                      return localitiesListStream.when(
                                        data: (data) {
                                          Locality customerLocality = Locality(
                                            name: 'Non définie',
                                            createdAt: DateTime.now(),
                                            updatedAt: DateTime.now(),
                                          );

                                          for (Locality localityData in data) {
                                            if (localityData.id ==
                                                customer.localityId) {
                                              customerLocality = localityData;
                                              break;
                                            }
                                          }

                                          return CBText(
                                            text: customerLocality.name,
                                            fontSize: 12.0,
                                          );
                                        },
                                        error: (error, stackTrace) =>
                                            const CBText(
                                          text: '',
                                        ),
                                        loading: () => const CBText(text: ''),
                                      );
                                    },
                                  )),
                                  DataCell(
                                    onTap: () {
                                      customer.signature != null
                                          ? FunctionsController.showAlertDialog(
                                              context: context,
                                              alertDialog: SingleImageShower(
                                                imageSource:
                                                    customer.signature!,
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
                                    onTap: () async {
                                      await FunctionsController.showAlertDialog(
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
                              );
                            },
                          ).toList();
                        },
                        error: (error, stackTrace) => [],
                        loading: () => [],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
