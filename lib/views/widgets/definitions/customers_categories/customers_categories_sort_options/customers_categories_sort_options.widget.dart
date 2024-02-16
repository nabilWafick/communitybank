import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/views/widgets/definitions/customers_categories/customers_categories_list/customers_categories_list.widget.dart';
import 'package:communitybank/views/widgets/forms/adding/customers_categories/customers_categories_adding_form.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomersCategoriesSortOptions extends ConsumerWidget {
  const CustomersCategoriesSortOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  ref.invalidate(custumersCategoriesListStreamProvider);
                },
              ),
              CBAddButton(
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const CustomerCategoryAddingForm(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
