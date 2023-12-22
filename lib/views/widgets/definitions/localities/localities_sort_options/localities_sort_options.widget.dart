import 'package:communitybank/views/widgets/forms/adding/localities/localities_adding_form.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalitiesSortOptions extends ConsumerWidget {
  const LocalitiesSortOptions({super.key});

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
                builder: (context) => const LocalitiesAddingForm(),
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
                hintText: 'Rechercher une localité',
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
