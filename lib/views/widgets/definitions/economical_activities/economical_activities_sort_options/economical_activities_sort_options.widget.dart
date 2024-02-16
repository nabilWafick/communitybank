import 'package:communitybank/views/widgets/definitions/economical_activities/economical_activities.widgets.dart';
import 'package:communitybank/views/widgets/forms/adding/economical_activities/economical_activities_adding_form.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EconomicalActivitiesSortOptions extends ConsumerWidget {
  const EconomicalActivitiesSortOptions({super.key});

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
                  ref.invalidate(economicalActivityListStreamProvider);
                },
              ),
              CBAddButton(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const EconomicalActivityAddingForm(),
                    // CustomersForm(),
                    // FormCard(),
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
