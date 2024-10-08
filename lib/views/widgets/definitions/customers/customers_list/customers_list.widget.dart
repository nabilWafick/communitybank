import 'package:communitybank/controllers/customers/customers.controller.dart';
import 'package:communitybank/controllers/forms/validators/customer/customer.validator.dart';
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
import 'package:horizontal_data_table/horizontal_data_table.dart';

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
  Widget build(BuildContext context) {
    final isSearching = ref.watch(isSearchingProvider('customers-name')) ||
        ref.watch(isSearchingProvider('customers-firstnames')) ||
        ref.watch(isSearchingProvider('customers-phoneNumber')) ||
        ref.watch(isSearchingProvider('customers-address'));
    final searchedCustomersList = ref.watch(searchedCustomersListProvider);
    final customersListStream = ref.watch(customersListStreamProvider);
    final customersList =
        isSearching ? searchedCustomersList : customersListStream;

    ref.listen(customersListStreamProvider, (previous, next) {
      if (isSearching) {
        ref.invalidate(searchedCustomersListProvider);
      }
    });

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: customersList.when(
          data: (data) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: MediaQuery.of(context).size.width + 2200,
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
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Photo',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Nom',
                  familyName: 'customers',
                  searchProvider: searchProvider('customers-name'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Prénoms',
                  familyName: 'customers-firstnames',
                  searchProvider: searchProvider('customers-firstnames'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Téléphone',
                  familyName: 'customers-phoneNumber',
                  searchProvider: searchProvider('customers-phoneNumber'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Adresse',
                  familyName: 'customers-address',
                  searchProvider: searchProvider('customers-address'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Numéro NCI',
                  familyName: 'customers-nicNumber',
                  searchProvider: searchProvider('customers-nicNumber'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Catégorie',
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Activité Économique',
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Status Personnel',
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Localité',
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Signature',
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
              final customer = data[index];
              return Row(
                children: [
                  InkWell(
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
                    child: Container(
                      alignment: Alignment.center,
                      width: 200.0,
                      height: 30.0,
                      child: customer.profile != null
                          ? const Icon(
                              Icons.photo,
                              color: CBColors.primaryColor,
                            )
                          : const SizedBox(),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: CBText(
                      text: customer.name,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: CBText(
                      text: customer.firstnames,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: CBText(
                      text: customer.phoneNumber,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: CBText(
                      text: customer.address,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: CBText(
                      text: customer.nicNumber?.toString() ?? '',
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    width: 300.0,
                    height: 30.0,
                    alignment: Alignment.center,
                    child: Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        final customersCategoriesListStream =
                            ref.watch(customersCategoriesListStreamProvider);

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
                                customerCategory = customerCategoryData;
                                break;
                              }
                            }

                            return CBText(
                              text: customerCategory.name,
                              fontSize: 12.0,
                            );
                          },
                          error: (error, stackTrace) => const CBText(
                            text: '',
                          ),
                          loading: () => const CBText(text: ''),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: 300.0,
                    height: 30.0,
                    alignment: Alignment.center,
                    child: Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        final economicalActivitiesListStream =
                            ref.watch(economicalActivitiesListStreamProvider);

                        return economicalActivitiesListStream.when(
                          data: (data) {
                            EconomicalActivity economicalActivity =
                                EconomicalActivity(
                              name: 'Non définie',
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            );

                            for (EconomicalActivity economicalActivityData
                                in data) {
                              if (economicalActivityData.id ==
                                  customer.economicalActivityId) {
                                economicalActivity = economicalActivityData;
                                break;
                              }
                            }

                            return CBText(
                              text: economicalActivity.name,
                              fontSize: 12.0,
                            );
                          },
                          error: (error, stackTrace) => const CBText(
                            text: '',
                          ),
                          loading: () => const CBText(text: ''),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: 300.0,
                    height: 30.0,
                    alignment: Alignment.center,
                    child: Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        final personalStatusListStream =
                            ref.watch(personalStatusListStreamProvider);

                        return personalStatusListStream.when(
                          data: (data) {
                            PersonalStatus personalStatus = PersonalStatus(
                              name: 'Non défini',
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            );

                            for (PersonalStatus personalStatusData in data) {
                              if (personalStatusData.id ==
                                  customer.personalStatusId) {
                                personalStatus = personalStatusData;
                                break;
                              }
                            }

                            return CBText(
                              text: personalStatus.name,
                              fontSize: 12.0,
                            );
                          },
                          error: (error, stackTrace) => const CBText(
                            text: '',
                          ),
                          loading: () => const CBText(text: ''),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: 300.0,
                    height: 30.0,
                    alignment: Alignment.center,
                    child: Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        final localitiesListStream =
                            ref.watch(localitiesListStreamProvider);

                        return localitiesListStream.when(
                          data: (data) {
                            Locality customerLocality = Locality(
                              name: 'Non définie',
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            );

                            for (Locality localityData in data) {
                              if (localityData.id == customer.localityId) {
                                customerLocality = localityData;
                                break;
                              }
                            }

                            return CBText(
                              text: customerLocality.name,
                              fontSize: 12.0,
                            );
                          },
                          error: (error, stackTrace) => const CBText(
                            text: '',
                          ),
                          loading: () => const CBText(text: ''),
                        );
                      },
                    ),
                  ),
                  InkWell(
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
                    child: Container(
                      alignment: Alignment.center,
                      width: 200.0,
                      height: 30.0,
                      child: customer.signature != null
                          ? const Icon(
                              Icons.photo,
                              color: CBColors.primaryColor,
                            )
                          : const SizedBox(),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      ref.read(customerProfilePictureProvider.notifier).state =
                          null;
                      ref
                          .read(customerSignaturePictureProvider.notifier)
                          .state = null;
                      FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: CustomerUpdateForm(
                          customer: customer,
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
                        alertDialog: CustomerDeletionConfirmationDialog(
                          customer: customer,
                          confirmToDelete: CustomerCRUDFunctions.delete,
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
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Photo',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Nom',
                  familyName: 'customers',
                  searchProvider: searchProvider('customers-name'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Prénoms',
                  familyName: 'customers-firstnames',
                  searchProvider: searchProvider('customers-firstnames'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Téléphone',
                  familyName: 'customers-phoneNumber',
                  searchProvider: searchProvider('customers-phoneNumber'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Adresse',
                  familyName: 'customers-address',
                  searchProvider: searchProvider('customers-address'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Numéro NCI',
                  familyName: 'customers-nicNumber',
                  searchProvider: searchProvider('customers-nicNumber'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Catégorie',
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Catégorie',
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Activité Économique',
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Status Personnel',
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Localité',
                  fontSize: 12,
                  textAlign: TextAlign.center,
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
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Photo',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Nom',
                  familyName: 'customers',
                  searchProvider: searchProvider('customers-name'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Prénoms',
                  familyName: 'customers-firstnames',
                  searchProvider: searchProvider('customers-firstnames'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Téléphone',
                  familyName: 'customers-phoneNumber',
                  searchProvider: searchProvider('customers-phoneNumber'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Adresse',
                  familyName: 'customers-address',
                  searchProvider: searchProvider('customers-address'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Numéro NCI',
                  familyName: 'customers-nicNumber',
                  searchProvider: searchProvider('customers-nicNumber'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Catégorie',
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Catégorie',
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Activité Économique',
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Status Personnel',
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Localité',
                  fontSize: 12,
                  textAlign: TextAlign.center,
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
