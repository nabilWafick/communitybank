import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/views/widgets/forms/adding/collectors/collectors_adding_form.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchedCollectorProvider = StateProvider<String>((ref) {
  return '';
});

class CollectorsSortOptions extends ConsumerWidget {
  const CollectorsSortOptions({super.key});

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
              FunctionsController.showAlertDialog(
                context: context,
                alertDialog: const CollectorsAddingForm(),
              );
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CBSearchInput(
                hintText: 'Rechercher un chargé de clientèle',
                searchProvider: searchedCollectorProvider,
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
