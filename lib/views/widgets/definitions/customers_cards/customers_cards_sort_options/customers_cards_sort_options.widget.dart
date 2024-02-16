import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards.widgets.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomersCardsSortOptions extends ConsumerWidget {
  const CustomersCardsSortOptions({super.key});

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
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: CBIconButton(
                  icon: Icons.refresh,
                  text: 'Rafraichir',
                  onTap: () {
                    ref.invalidate(customersCardsListStreamProvider);
                  },
                ),
              ),
              /* CBAddButton(
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const CustomerCardAddingForm(),
                  );
                },
              ),*/
            ],
          ),
        ],
      ),
    );
  }
}
