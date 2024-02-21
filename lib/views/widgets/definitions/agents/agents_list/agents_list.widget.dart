import 'package:communitybank/controllers/agent/agent.controller.dart';
import 'package:communitybank/controllers/forms/validators/agent/agent.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/agents/agent_crud.function.dart';
import 'package:communitybank/models/data/agent/agent.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/agents/agents_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/agent/agent_update_form.widget.dart';
import 'package:communitybank/views/widgets/globals/images_shower/single/single_image_shower.widget.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/globals/search_input/search_input.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchedAgentsListProvider = StreamProvider<List<Agent>>((ref) async* {
  // Agent name
  String searchedAgentName = ref.watch(searchProvider('agents-name'));
  ref.listen(searchProvider('agents-name'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('agents-name').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('agents-name').notifier).state = false;
    }
  });

  // Agent firstnames
  String searchedAgentFirstnames =
      ref.watch(searchProvider('agents-firstnames'));
  ref.listen(searchProvider('agents-firstnames'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('agents-firstnames').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('agents-firstnames').notifier).state = false;
    }
  });

  // Agent Email
  String searchedAgentEmail = ref.watch(searchProvider('agents-email'));
  ref.listen(searchProvider('agents-email'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('agents-email').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('agents-email').notifier).state = false;
    }
  });

  // Agent phoneNumber
  String searchedAgentPhoneNumber =
      ref.watch(searchProvider('agents-phoneNumber'));
  ref.listen(searchProvider('agents-phoneNumber'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('agents-phoneNumber').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('agents-phoneNumber').notifier).state =
          false;
    }
  });

  // Agent address
  String searchedAgentAddress = ref.watch(searchProvider('agents-address'));
  ref.listen(searchProvider('agents-address'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('agents-address').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('agents-address').notifier).state = false;
    }
  });

  // Agent role
  String searchedAgentRole = ref.watch(searchProvider('agents-role'));
  ref.listen(searchProvider('agents-role'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('agents-role').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('agents-role').notifier).state = false;
    }
  });

  yield* AgentsController.searchAgent(
    searchedAgentName: searchedAgentName,
    searchedAgentFirstnames: searchedAgentFirstnames,
    searchedAgentEmail: searchedAgentEmail,
    searchedAgentPhoneNumber: searchedAgentPhoneNumber,
    searchedAgentAddress: searchedAgentAddress,
    searchedAgentRole: searchedAgentRole,
  ).asStream();
});

final agentsListStreamProvider = StreamProvider<List<Agent>>((ref) async* {
  yield* AgentsController.getAll();
});

class AgentsList extends StatefulHookConsumerWidget {
  const AgentsList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AgentsListState();
}

class _AgentsListState extends ConsumerState<AgentsList> {
  final ScrollController horizontallScrollController = ScrollController();
  final ScrollController verticalScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final isSearching = ref.watch(isSearchingProvider('agents-name')) ||
        ref.watch(isSearchingProvider('agents-firstnames')) ||
        ref.watch(isSearchingProvider('agents-email')) ||
        ref.watch(isSearchingProvider('agents-phoneNumber')) ||
        ref.watch(isSearchingProvider('agents-address')) ||
        ref.watch(isSearchingProvider('agents-role'));
    final searchedAgentsList = ref.watch(searchedAgentsListProvider);
    final agentsListStream = ref.watch(agentsListStreamProvider);
    return SizedBox(
      height: 600.0,
      child: Scrollbar(
        controller: horizontallScrollController,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            controller: horizontallScrollController,
            child: Scrollbar(
              controller: verticalScrollController,
              child: SingleChildScrollView(
                controller: verticalScrollController,
                child: DataTable(
                  showCheckboxColumn: true,
                  columns: [
                    const DataColumn(
                      label: CBText(
                        text: 'Code',
                        textAlign: TextAlign.start,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const DataColumn(
                      label: CBText(
                        text: 'Photo',
                        textAlign: TextAlign.start,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    DataColumn(
                      label: CBSearchInput(
                        hintText: 'Nom',
                        familyName: 'agents-name',
                        searchProvider: searchProvider('agents-name'),
                      ),

                      /* CBText(
                        text: 'Nom & Prénoms',
                        textAlign: TextAlign.start,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),*/
                    ),
                    DataColumn(
                      label: CBSearchInput(
                        hintText: 'Prénoms',
                        familyName: 'agents-firstnames',
                        searchProvider: searchProvider('agents-firstnames'),
                      ),

                      /* CBText(
                        text: 'Nom & Prénoms',
                        textAlign: TextAlign.start,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),*/
                    ),
                    DataColumn(
                      label: CBSearchInput(
                        hintText: 'Téléphone',
                        familyName: 'agents-phoneNumber',
                        searchProvider: searchProvider('agents-phoneNumber'),
                      ),

                      /* CBText(
                        text: 'Téléphone',
                        textAlign: TextAlign.start,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),*/
                    ),
                    DataColumn(
                      label: CBSearchInput(
                        hintText: 'Email',
                        familyName: 'agents-email',
                        searchProvider: searchProvider('agents-email'),
                      ),
                      /*CBText(
                        text: 'Email',
                        textAlign: TextAlign.start,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),*/
                    ),
                    DataColumn(
                      label: CBSearchInput(
                        hintText: 'Adresse',
                        familyName: 'agents-address',
                        searchProvider: searchProvider('agents-address'),
                      ),

                      /* CBText(
                        text: 'Adresse',
                        textAlign: TextAlign.start,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),*/
                    ),
                    DataColumn(
                      label: CBSearchInput(
                        hintText: 'Rôle',
                        familyName: 'agents-role',
                        searchProvider: searchProvider('agents-role'),
                      ),

                      /* CBText(
                        text: 'Role',
                        textAlign: TextAlign.start,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),*/
                    ),
                    const DataColumn(
                      label: SizedBox(),
                    ),
                    const DataColumn(
                      label: SizedBox(),
                    ),
                  ],
                  rows: isSearching
                      ? searchedAgentsList.when(
                          data: (data) {
                            //  debugPrint('Agent Stream Data: $data');
                            return data
                                .map(
                                  (agent) => DataRow(
                                    cells: [
                                      DataCell(
                                        CBText(
                                          text: '${data.indexOf(agent) + 1}',
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      DataCell(
                                        onTap: () {
                                          agent.profile != null
                                              ? FunctionsController
                                                  .showAlertDialog(
                                                  context: context,
                                                  alertDialog:
                                                      SingleImageShower(
                                                    imageSource: agent.profile!,
                                                  ),
                                                )
                                              : () {};
                                        },
                                        Container(
                                          alignment: Alignment.center,
                                          child: agent.profile != null
                                              ? const Icon(
                                                  Icons.photo,
                                                  color: CBColors.primaryColor,
                                                )
                                              : const SizedBox(),
                                        ),
                                      ),
                                      DataCell(
                                        CBText(
                                          text: agent.name,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      DataCell(
                                        CBText(
                                          text: agent.firstnames,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      DataCell(
                                        CBText(
                                          text: agent.phoneNumber,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      DataCell(
                                        CBText(
                                          text: agent.email,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      DataCell(
                                        CBText(
                                          text: agent.address,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      DataCell(
                                        CBText(
                                          text: agent.role,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      DataCell(
                                        onTap: () {
                                          ref
                                              .read(
                                                  agentPictureProvider.notifier)
                                              .state = null;
                                          FunctionsController.showAlertDialog(
                                            context: context,
                                            alertDialog: AgentUpdateForm(
                                              agent: agent,
                                            ),
                                          );
                                        },
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                          ),
                                        ),
                                        // showEditIcon: true,
                                      ),
                                      DataCell(
                                        onTap: () async {
                                          FunctionsController.showAlertDialog(
                                            context: context,
                                            alertDialog:
                                                AgentDeletionConfirmationDialog(
                                              agent: agent,
                                              confirmToDelete:
                                                  AgentCRUDFunctions.delete,
                                            ),
                                          );
                                        },
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: const Icon(
                                            Icons.delete_sharp,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList();
                          },
                          error: (error, stack) {
                            //  debugPrint('Agents Stream Error');
                            return [];
                          },
                          loading: () {
                            //  debugPrint('Agents Stream Loading');
                            return [];
                          },
                        )
                      : agentsListStream.when(
                          data: (data) {
                            //  debugPrint('Agent Stream Data: $data');
                            return data
                                .map(
                                  (agent) => DataRow(
                                    cells: [
                                      DataCell(
                                        CBText(
                                          text: '${data.indexOf(agent) + 1}',
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      DataCell(
                                        onTap: () {
                                          agent.profile != null
                                              ? FunctionsController
                                                  .showAlertDialog(
                                                  context: context,
                                                  alertDialog:
                                                      SingleImageShower(
                                                    imageSource: agent.profile!,
                                                  ),
                                                )
                                              : () {};
                                        },
                                        Container(
                                          alignment: Alignment.center,
                                          child: agent.profile != null
                                              ? const Icon(
                                                  Icons.photo,
                                                  color: CBColors.primaryColor,
                                                )
                                              : const SizedBox(),
                                        ),
                                      ),
                                      DataCell(
                                        CBText(
                                          text: agent.name,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      DataCell(
                                        CBText(
                                          text: agent.firstnames,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      DataCell(
                                        CBText(
                                          text: agent.phoneNumber,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      DataCell(
                                        CBText(
                                          text: agent.email,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      DataCell(
                                        CBText(
                                          text: agent.address,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      DataCell(
                                        CBText(
                                          text: agent.role,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      DataCell(
                                        onTap: () {
                                          ref
                                              .read(
                                                  agentPictureProvider.notifier)
                                              .state = null;
                                          FunctionsController.showAlertDialog(
                                            context: context,
                                            alertDialog: AgentUpdateForm(
                                              agent: agent,
                                            ),
                                          );
                                        },
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                          ),
                                        ),
                                        // showEditIcon: true,
                                      ),
                                      DataCell(
                                        onTap: () async {
                                          FunctionsController.showAlertDialog(
                                            context: context,
                                            alertDialog:
                                                AgentDeletionConfirmationDialog(
                                              agent: agent,
                                              confirmToDelete:
                                                  AgentCRUDFunctions.delete,
                                            ),
                                          );
                                        },
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: const Icon(
                                            Icons.delete_sharp,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList();
                          },
                          error: (error, stack) {
                            //  debugPrint('Agents Stream Error');
                            return [];
                          },
                          loading: () {
                            //  debugPrint('Agents Stream Loading');
                            return [];
                          },
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
