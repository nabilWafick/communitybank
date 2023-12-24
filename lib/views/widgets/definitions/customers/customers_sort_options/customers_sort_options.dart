import 'package:communitybank/views/widgets/forms/adding/customers/customers_adding_form.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchedCustomersProvider = StateProvider<String>((ref) {
  return '';
});

class CustomersSortOptions extends ConsumerWidget {
  const CustomersSortOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 40.0,
      ),
      width: double.maxFinite,
      child: Column(
        children: [
          CBAddButton(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const CustomersAddingForm(),
                // CustomersForm(),
                // FormCard(),
              );
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CBSearchInput(
                hintText: 'Rechercher un client',
                searchProvider: searchedCustomersProvider,
              ),
              const Row(
                children: [
                  CBText(text: 'Trier par'),
                  SizedBox(
                    width: 15.0,
                  ),
                  CBDropdown(
                    label: 'Catégorie',
                    dropdownMenuEntriesLabels: [
                      'Toutes',
                      'Particulier Homme',
                      'Particulier Femme',
                    ],
                    dropdownMenuEntriesValues: [
                      '*',
                      'Particulier Homme',
                      'Particulier Femme',
                    ],
                  ),
                  CBDropdown(
                    label: 'Activité économique',
                    dropdownMenuEntriesLabels: [
                      'Toutes',
                      'Commerce',
                      'Enseignement',
                      'Artisanat',
                    ],
                    dropdownMenuEntriesValues: [
                      '*',
                      'Commerce',
                      'Enseignement',
                      'Artisanat',
                    ],
                  ),
                  CBDropdown(
                    label: 'Statut Personnel',
                    dropdownMenuEntriesLabels: [
                      'Tous',
                      'Micro-Entrepreneur',
                      'Commerçant',
                      'Artisant',
                    ],
                    dropdownMenuEntriesValues: [
                      '*',
                      'Micro-Entrepreneur',
                      'Commerçant',
                      'Artisant',
                    ],
                  ),
                  CBDropdown(
                    label: 'Localité',
                    dropdownMenuEntriesLabels: [
                      'Toutes',
                      'Aitchédji',
                      'Zogbadjè',
                      'Plateau',
                      'Tankpè'
                    ],
                    dropdownMenuEntriesValues: [
                      '*',
                      'Aitchédji',
                      'Zogbadjè',
                      'Plateau',
                      'Tankpè'
                    ],
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
