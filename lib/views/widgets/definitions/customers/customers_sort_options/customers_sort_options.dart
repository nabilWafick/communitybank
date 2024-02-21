import 'package:communitybank/controllers/forms/validators/customer/customer.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/customers_category/customers_category.model.dart';
import 'package:communitybank/models/data/economical_activity/economical_activity.model.dart';
import 'package:communitybank/models/data/locality/locality.model.dart';
import 'package:communitybank/models/data/personal_status/personal_status.model.dart';
import 'package:communitybank/views/widgets/definitions/customers/customers.widgets.dart';
import 'package:communitybank/views/widgets/definitions/customers_categories/customers_categories_list/customers_categories_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/economical_activities/economical_activities_list/economical_activities_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/localities/localities_list/localities_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/personal_status/personal_status_list/personal_status_list.widget.dart';
import 'package:communitybank/views/widgets/forms/adding/customers/customers_adding_form.widget.dart';
import 'package:communitybank/views/widgets/globals/add_button/add_button.widget.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_category/customer_category_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/economical_activity/economical_activity_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/locality/locality_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/personal_status/personal_status_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomersSortOptions extends ConsumerWidget {
  const CustomersSortOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final economicalActivitiesListStream =
        ref.watch(economicalActivitiesListStreamProvider);
    final customersCategoriesListStream =
        ref.watch(customersCategoriesListStreamProvider);
    final localitiesListStream = ref.watch(localitiesListStreamProvider);
    final personalStatusListStream =
        ref.watch(personalStatusListStreamProvider);
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      width: double.maxFinite,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CBIconButton(
                icon: Icons.refresh,
                text: 'Rafraichir',
                onTap: () {
                  ref.invalidate(customersListStreamProvider);
                },
              ),
              CBAddButton(
                onTap: () {
                  ref.read(isThereSimilarCustomersProvider.notifier).state =
                      false;
                  ref.read(customerProfilePictureProvider.notifier).state =
                      null;
                  ref.read(customerSignaturePictureProvider.notifier).state =
                      null;
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const CustomerAddingForm(),
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Row(
                children: [
                  const CBText(
                    text: 'Trier par',
                    fontSize: 12.0,
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  CBListCustomerCategoryDropdown(
                    width: 200.0,
                    menuHeigth: 500.0,
                    label: 'Catégorie',
                    providerName: 'customer-list-sort-category',
                    dropdownMenuEntriesLabels:
                        customersCategoriesListStream.when(
                      data: (data) {
                        return [
                          CustomerCategory(
                            id: 0,
                            name: 'Tous',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          CustomerCategory(
                            name: 'Non définie',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          ...data
                        ];
                      },
                      error: (error, stackTrace) => [],
                      loading: () => [],
                    ),
                    dropdownMenuEntriesValues:
                        customersCategoriesListStream.when(
                      data: (data) {
                        return [
                          CustomerCategory(
                            id: 0,
                            name: 'Tous',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          CustomerCategory(
                            name: 'Non définie',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          ...data
                        ];
                      },
                      error: (error, stackTrace) => [],
                      loading: () => [],
                    ),
                  ),
                  CBListEconomicalActivityDropdown(
                    width: 200.0,
                    menuHeigth: 500.0,
                    label: 'Activité économique',
                    providerName: 'customer-list-sort-economical-activity',
                    dropdownMenuEntriesLabels:
                        economicalActivitiesListStream.when(
                      data: (data) {
                        return [
                          EconomicalActivity(
                            id: 0,
                            name: 'Tous',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          EconomicalActivity(
                            name: 'Non définie',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          ...data
                        ];
                      },
                      error: (error, stackTrace) => [],
                      loading: () => [],
                    ),
                    dropdownMenuEntriesValues:
                        economicalActivitiesListStream.when(
                      data: (data) {
                        return [
                          EconomicalActivity(
                            id: 0,
                            name: 'Tous',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          EconomicalActivity(
                            name: 'Non définie',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          ...data
                        ];
                      },
                      error: (error, stackTrace) => [],
                      loading: () => [],
                    ),
                  ),
                  CBListPersonalStatusDropdown(
                    width: 200.0,
                    menuHeigth: 500.0,
                    label: 'Statut Personnel',
                    providerName: 'customer-list-sort-personal-status',
                    dropdownMenuEntriesLabels: personalStatusListStream.when(
                      data: (data) {
                        return [
                          PersonalStatus(
                            id: 0,
                            name: 'Tous',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          PersonalStatus(
                            name: 'Non défini',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          ...data
                        ];
                      },
                      error: (error, stackTrace) => [],
                      loading: () => [],
                    ),
                    dropdownMenuEntriesValues: personalStatusListStream.when(
                      data: (data) {
                        return [
                          PersonalStatus(
                            id: 0,
                            name: 'Tous',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          PersonalStatus(
                            name: 'Non défini',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          ...data
                        ];
                      },
                      error: (error, stackTrace) => [],
                      loading: () => [],
                    ),
                  ),
                  CBListLocalityDropdown(
                    width: 200.0,
                    menuHeigth: 500.0,
                    label: 'Localité',
                    providerName: 'customer-list-sort-locality',
                    dropdownMenuEntriesLabels: localitiesListStream.when(
                      data: (data) {
                        return [
                          Locality(
                            id: 0,
                            name: 'Tous',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          Locality(
                            name: 'Non définie',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          ...data
                        ];
                      },
                      error: (error, stackTrace) => [],
                      loading: () => [],
                    ),
                    dropdownMenuEntriesValues: localitiesListStream.when(
                      data: (data) {
                        return [
                          Locality(
                            id: 0,
                            name: 'Tous',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          Locality(
                            name: 'Non définie',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          ...data
                        ];
                      },
                      error: (error, stackTrace) => [],
                      loading: () => [],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
