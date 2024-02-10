//import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/controllers/forms/validators/collection/collection.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/agent/agent.model.dart';
import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/views/widgets/definitions/agents/agents.widgets.dart';
import 'package:communitybank/views/widgets/definitions/collectors/collectors.widgets.dart';
import 'package:communitybank/views/widgets/definitions/collections/collections_list/collections_list.widget.dart';
import 'package:communitybank/views/widgets/forms/adding/collections/collections_adding_form.widget.dart';
import 'package:communitybank/views/widgets/globals/add_button/add_button.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/agent/agent_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/collector/collector_dropdown.widget.dart';
//import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
//import 'package:intl/intl.dart';

final collectionsListCollectionDateProvider = StateProvider<DateTime?>((ref) {
  return;
});

final collectionsListEntryDateProvider = StateProvider<DateTime?>((ref) {
  return;
});

class CollectionsSortOptions extends StatefulHookConsumerWidget {
  const CollectionsSortOptions({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectionsSortOptionsState();
}

class _CollectionsSortOptionsState
    extends ConsumerState<CollectionsSortOptions> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final collectorsListStream = ref.watch(collectorsListStreamProvider);
    final agentsListStream = ref.watch(agentsListStreamProvider);
    final collectionsListCollectionDate =
        ref.watch(collectionsListCollectionDateProvider);
    //  final collectionsListEntryDate =
    //      ref.watch(collectionsListEntryDateProvider);

    final format = DateFormat.yMMMMEEEEd('fr');
    return Container(
      margin: const EdgeInsets.only(
        bottom: 40.0,
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
                  ref.invalidate(collectionsListStreamProvider);
                },
              ),
              CBAddButton(
                onTap: () {
                  ref.read(collectionDateProvider.notifier).state = null;
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const CollectionAddingForm(),
                  );
                },
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*  CBSearchInput(
                  hintText: 'Rechercher un règlement',
                  searchProvider: searchProvider('collections'),
                ),*/
                const SizedBox(
                  width: 10.0,
                ),
                SizedBox(
                  width: 320.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CBIconButton(
                        icon: Icons.date_range,
                        text: 'Date de Collecte',
                        onTap: () async {
                          await FunctionsController.showDateTime(
                            context,
                            ref,
                            collectionsListCollectionDateProvider,
                          );
                        },
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Flexible(
                        child: CBText(
                          text: collectionsListCollectionDate != null
                              ? format.format(collectionsListCollectionDate)
                              : '',
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ),
                      //   const SizedBox(),
                    ],
                  ),
                ),
                CBListCollectorDropdown(
                  width: 300.0,
                  label: 'Chargé de compte',
                  providerName: 'collections-collector',
                  dropdownMenuEntriesLabels: collectorsListStream.when(
                    data: (data) => [
                      Collector(
                        name: 'Tous',
                        firstnames: '',
                        phoneNumber: '',
                        address: '',
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
                      ...data
                    ],
                    error: (error, stackTrace) => [],
                    loading: () => [],
                  ),
                  dropdownMenuEntriesValues: collectorsListStream.when(
                    data: (data) => [
                      Collector(
                        name: 'Tous',
                        firstnames: '',
                        phoneNumber: '',
                        address: '',
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
                      ...data
                    ],
                    error: (error, stackTrace) => [],
                    loading: () => [],
                  ),
                ),
                CBListAgentDropdown(
                  width: 300.0,
                  label: 'Agent',
                  providerName: 'collections-agent',
                  dropdownMenuEntriesLabels: agentsListStream.when(
                    data: (data) => [
                      Agent(
                        name: 'Tous',
                        firstnames: '',
                        phoneNumber: '',
                        address: '',
                        email: '',
                        role: '',
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
                      ...data
                    ],
                    error: (error, stackTrace) => [],
                    loading: () => [],
                  ),
                  dropdownMenuEntriesValues: agentsListStream.when(
                    data: (data) => [
                      Agent(
                        name: 'Tous',
                        firstnames: '',
                        phoneNumber: '',
                        address: '',
                        email: '',
                        role: '',
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
                      ...data
                    ],
                    error: (error, stackTrace) => [],
                    loading: () => [],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
