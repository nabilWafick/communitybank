import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/customers_category/customers_category.model.dart';
import 'package:communitybank/models/data/economical_activity/economical_activity.model.dart';
import 'package:communitybank/models/data/locality/locality.model.dart';
import 'package:communitybank/models/data/personal_status/personal_status.model.dart';
import 'package:communitybank/views/widgets/definitions/customers_categories/customers_categories_list/customers_categories_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/economical_activities/economical_activities_list/economical_activities_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/localities/localities_list/localities_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/personal_status/personal_status_list/personal_status_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/products/products.widgets.dart';
import 'package:communitybank/views/widgets/forms/adding/customers/customers_adding_form.widget.dart';
import 'package:communitybank/views/widgets/globals/customer_category_dropdown/customer_category_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/economical_activity_dropdown/economical_activity_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/locality_dropdown/locality_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/personal_status_dropdown/personal_status_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomersSortOptions extends ConsumerWidget {
  const CustomersSortOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final economicalActivitiesListStream =
        ref.watch(economicalActivityListStreamProvider);
    final customersCategoriesListStream =
        ref.watch(custumersCategoriesListStreamProvider);
    final localitiesListStream = ref.watch(localityListStreamProvider);
    final personalStatusListStream =
        ref.watch(personalStatusListStreamProvider);
    return Container(
      margin: const EdgeInsets.only(
        bottom: 40.0,
      ),
      width: double.maxFinite,
      child: Column(
        children: [
          CBAddButton(
            onTap: () {
              FunctionsController.showAlertDialog(
                context: context,
                alertDialog: const CustomerAddingForm(),
              );
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CBSearchInput(
                hintText: 'Rechercher un client',
                searchProvider: searchProvider('customers'),
              ),
              Row(
                children: [
                  const CBText(text: 'Trier par'),
                  const SizedBox(
                    width: 15.0,
                  ),
                  CBCustomerCategoryDropdown(
                    // width: formCardWidth / 2.3,
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
                            name: 'Aucun',
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
                            name: 'Aucun',
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
                  CBEconomicalActivityDropdown(
                    //   width: formCardWidth / 2.3,
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
                            name: 'Aucun',
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
                            name: 'Aucun',
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
                  CBPersonalStatusDropdown(
                    //     width: formCardWidth / 2.3,
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
                            name: 'Aucun',
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
                            name: 'Aucun',
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
                  CBLocalityDropdown(
                    //  width: formCardWidth / 2.3,
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
                            name: 'Aucun',
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
                            name: 'Aucun',
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
