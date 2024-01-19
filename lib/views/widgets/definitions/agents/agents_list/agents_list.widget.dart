import 'package:communitybank/controllers/agent/agent.controller.dart';
import 'package:communitybank/controllers/forms/validators/agent/agent.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/agents/agent_crud.function.dart';
import 'package:communitybank/models/data/agent/agent.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/images_shower/single/single_image_shower.widget.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/agent/agents_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchedAgentsListProvider = StreamProvider<List<Agent>>((ref) async* {
  String searchedAgent = ref.watch(searchProvider('agents'));
  ref.listen(searchProvider('agents'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('agents').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('agents').notifier).state = false;
    }
  });
  yield* AgentsController.searchAgent(name: searchedAgent).asStream();
});

final agentsListStreamProvider = StreamProvider<List<Agent>>((ref) async* {
  yield* AgentsController.getAll();
});

class AgentsList extends ConsumerWidget {
  const AgentsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearching = ref.watch(isSearchingProvider('agents'));
    final searchedAgentsList = ref.watch(searchedAgentsListProvider);
    final agentsListStream = ref.watch(agentsListStreamProvider);
    return SizedBox(
      height: 640.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            showCheckboxColumn: true,
            columns: const [
              DataColumn(
                label: CBText(
                  text: 'Code',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Photo',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Nom & Prénoms',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Téléphone',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Adresse',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Role',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: SizedBox(),
              ),
              DataColumn(
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
                                    text: agent.id!.toString(),
                                  ),
                                ),
                                DataCell(
                                  onTap: () {
                                    agent.profile != null
                                        ? FunctionsController.showAlertDialog(
                                            context: context,
                                            alertDialog: SingleImageShower(
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
                                      text:
                                          '${agent.name} ${agent.firstnames}'),
                                ),
                                DataCell(
                                  CBText(text: agent.phoneNumber),
                                ),
                                DataCell(
                                  CBText(text: agent.address),
                                ),
                                DataCell(
                                  CBText(text: agent.role),
                                ),
                                DataCell(
                                  onTap: () {
                                    ref
                                        .read(agentPictureProvider.notifier)
                                        .state = null;
                                    //  FunctionsController.showAlertDialog(
                                    //    context: context,
                                    //    alertDialog: AgentUpdateForm(
                                    //      Agent: Agent,
                                    //    ),
                                    //  );
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
                                    text: agent.id!.toString(),
                                  ),
                                ),
                                DataCell(
                                  onTap: () {
                                    agent.profile != null
                                        ? FunctionsController.showAlertDialog(
                                            context: context,
                                            alertDialog: SingleImageShower(
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
                                      text:
                                          '${agent.name} ${agent.firstnames}'),
                                ),
                                DataCell(
                                  CBText(text: agent.phoneNumber),
                                ),
                                DataCell(
                                  CBText(text: agent.address),
                                ),
                                DataCell(
                                  CBText(text: agent.role),
                                ),
                                DataCell(
                                  onTap: () {
                                    ref
                                        .read(agentPictureProvider.notifier)
                                        .state = null;
                                    /*    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: AgentUpdateForm(
                                        Agent: Agent,
                                      ),
                                    );
                                 */
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
                                    /*   FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog:
                                          AgentDeletionConfirmationDialog(
                                        Agent: Agent,
                                        confirmToDelete:
                                            AgentCRUDFunctions.delete,
                                      ),
                                    ); 
                                    */
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
    );
  }
}
