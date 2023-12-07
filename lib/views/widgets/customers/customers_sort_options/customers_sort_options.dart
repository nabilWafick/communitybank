import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          CBAddButton(onTap: () {}),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CBSearchInput(
                hintText: 'Rechercher un client',
                onChanged: (value, ref) {},
              ),
              const Row(
                children: [
                  CBText(text: 'Trier par'),
                  SizedBox(
                    width: 15.0,
                  ),
                  CBDropdown(
                    label: 'Collecteurs',
                    dropdownMenuEntriesLabels: [
                      'Collecteur 1',
                      'Collecteur 2',
                      'Collecteur 3',
                      'Collecteur 4',
                      'Collecteur 5',
                    ],
                    dropdownMenuEntriesValues: [
                      'Collecteur 1',
                      'Collecteur 2',
                      'Collecteur 3',
                      'Collecteur 4',
                      'Collecteur 5',
                    ],
                  ),
                  CBDropdown(
                    label: 'Types',
                    dropdownMenuEntriesLabels: [
                      'Type 1',
                      'Type 2',
                      'Type 3',
                      'Type 4',
                      'Type 5',
                    ],
                    dropdownMenuEntriesValues: [
                      'Type 1',
                      'Type 2',
                      'Type 3',
                      'Type 4',
                      'Type 5',
                    ],
                  ),
                  CBDropdown(
                    label: 'Jours',
                    dropdownMenuEntriesLabels: [
                      '1 Jour',
                      '2 Jours',
                      '3 Jours',
                      '4 Jours',
                      '5 Jours',
                      '6 Jours',
                      '7 Jours',
                    ],
                    dropdownMenuEntriesValues: [
                      '1 Jour',
                      '2 Jours',
                      '3 Jours',
                      '4 Jours',
                      '5 Jours',
                      '6 Jours',
                      '7 Jours',
                    ],
                  ),
                  CBDropdown(
                    label: 'Nbre Cartes',
                    dropdownMenuEntriesLabels: [
                      'Décroissant',
                      'Croissant',
                    ],
                    dropdownMenuEntriesValues: [
                      'Décroissant',
                      'Croissant',
                    ],
                  ),
                  CBDropdown(
                    label: 'Status',
                    dropdownMenuEntriesLabels: [
                      'Satisfait',
                      'Non Satisfait',
                      'Payé',
                    ],
                    dropdownMenuEntriesValues: [
                      'Satisfait',
                      'Non Satisfait',
                      'Payé',
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
