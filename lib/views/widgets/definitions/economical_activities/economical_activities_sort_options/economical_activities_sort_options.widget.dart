import 'package:communitybank/views/widgets/forms/economical_activities/economical_activities_form.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EconomicalActivitiesSortOptions extends ConsumerWidget {
  const EconomicalActivitiesSortOptions({super.key});

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
                builder: (context) => const AlertDialog(
                  contentPadding: EdgeInsetsDirectional.symmetric(
                    vertical: 20.0,
                    horizontal: 10.0,
                  ),
                  content: EconomicalActivitiesForm(),
                  // CustomersForm(),
                  // FormCard(),
                ),
              );
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CBSearchInput(
                hintText: 'Rechercher une activité économique',
                onChanged: (value, ref) {},
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
