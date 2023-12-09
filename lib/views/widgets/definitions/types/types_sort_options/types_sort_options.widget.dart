import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TypesSortOptions extends ConsumerWidget {
  const TypesSortOptions({super.key});

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
                hintText: 'Rechercher un type',
                onChanged: (value, ref) {},
              ),
              const Row(
                children: [
                  CBText(
                    text: 'Trier par',
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  CBDropdown(
                    label: 'Mise',
                    dropdownMenuEntriesLabels: [
                      '100f/Jour',
                      '150f/Jour',
                      '200f/Jour',
                      '250f/Jour',
                      '300f/Jour',
                    ],
                    dropdownMenuEntriesValues: [
                      '100',
                      '150',
                      '200',
                      '250',
                      '300',
                    ],
                  ),
                  CBDropdown(
                    label: 'Produit',
                    dropdownMenuEntriesLabels: [
                      'Produit 1',
                      'Produit 2',
                      'Produit 3',
                      'Produit 4',
                      'Produit 5',
                    ],
                    dropdownMenuEntriesValues: [
                      'Produit 1',
                      'Produit 2',
                      'Produit 3',
                      'Produit 4',
                      'Produit 5',
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
