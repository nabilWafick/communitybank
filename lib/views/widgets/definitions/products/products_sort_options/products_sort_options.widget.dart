import 'package:communitybank/controllers/forms/validators/product/product.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/views/widgets/forms/adding/products/products_adding_form.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsSortOptions extends ConsumerWidget {
  const ProductsSortOptions({super.key});

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
              ref.read(productPictureProvider.notifier).state = null;
              FunctionsController.showAlertDialog(
                context: context,
                alertDialog: const ProductAddingForm(),
              );
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CBSearchInput(
                hintText: 'Rechercher un produit',
                onChanged: (value, ref) {},
              ),
              const Row(
                children: [
                  CBText(text: 'Trier par'),
                  SizedBox(
                    width: 15.0,
                  ),
                  CBDropdown(
                    label: 'Prix',
                    dropdownMenuEntriesLabels: [
                      'Tous',
                      '1000f',
                      '1500f',
                      '2000f',
                      '2500f',
                      '3000f',
                    ],
                    dropdownMenuEntriesValues: [
                      '*',
                      '1000',
                      '1500',
                      '2000',
                      '2500',
                      '3000',
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
