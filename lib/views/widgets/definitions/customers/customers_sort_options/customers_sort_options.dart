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
