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
import 'package:horizontal_data_table/horizontal_data_table.dart';

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
  @override
  Widget build(BuildContext context) {
    final isSearching = ref.watch(isSearchingProvider('agents-name')) ||
        ref.watch(isSearchingProvider('agents-firstnames')) ||
        ref.watch(isSearchingProvider('agents-phoneNumber')) ||
        ref.watch(isSearchingProvider('agents-address')) ||
        ref.watch(isSearchingProvider('agents-role'));
    final searchedAgentsList = ref.watch(searchedAgentsListProvider);
    final agentsListStream = ref.watch(agentsListStreamProvider);
    final agentsList = isSearching ? searchedAgentsList : agentsListStream;

    ref.listen(agentsListStreamProvider, (previous, next) {
      if (isSearching) {
        ref.invalidate(searchedAgentsListProvider);
      }
    });

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: agentsList.when(
          data: (data) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: MediaQuery.of(context).size.width + 1200,
            itemCount: data.length,
            isFixedHeader: true,
            leftHandSideColBackgroundColor: CBColors.backgroundColor,
            rightHandSideColBackgroundColor: CBColors.backgroundColor,
            headerWidgets: [
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'N°',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Photo',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Nom',
                  familyName: 'collectors',
                  searchProvider: searchProvider('agents-name'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Prénoms',
                  familyName: 'agents-firstnames',
                  searchProvider: searchProvider('agents-firstnames'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Email',
                  familyName: 'agents-email',
                  searchProvider: searchProvider('agents-email'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Téléphone',
                  familyName: 'agents-phoneNumber',
                  searchProvider: searchProvider('agents-phoneNumber'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Adresse',
                  familyName: 'agents-address',
                  searchProvider: searchProvider('agents-address'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Rôle',
                  familyName: 'agents-role',
                  searchProvider: searchProvider('agents-role'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
            ],
            leftSideItemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                width: 200.0,
                height: 30.0,
                child: CBText(
                  text: '${index + 1}',
                  fontSize: 12.0,
                ),
              );
            },
            rightSideItemBuilder: (BuildContext context, int index) {
              final agent = data[index];
              return Row(
                children: [
                  InkWell(
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
                    child: Container(
                      alignment: Alignment.center,
                      width: 200.0,
                      height: 30.0,
                      child: agent.profile != null
                          ? const Icon(
                              Icons.photo,
                              color: CBColors.primaryColor,
                            )
                          : const SizedBox(),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: CBText(
                      text: agent.name,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: CBText(
                      text: agent.firstnames,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: CBText(
                      text: agent.email,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: CBText(
                      text: agent.phoneNumber,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: CBText(
                      text: agent.address,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: CBText(
                      text: agent.role,
                      fontSize: 12.0,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      ref.read(agentPictureProvider.notifier).state = null;
                      FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: AgentUpdateForm(
                          agent: agent,
                        ),
                      );
                    },
                    child: Container(
                      width: 150.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.edit,
                        color: Colors.green[500],
                      ),
                    ),
                    // showEditIcon: true,
                  ),
                  InkWell(
                    onTap: () async {
                      FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: AgentDeletionConfirmationDialog(
                          agent: agent,
                          confirmToDelete: AgentCRUDFunctions.delete,
                        ),
                      );
                    },
                    child: Container(
                      width: 150.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.delete_sharp,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              );
            },
            rowSeparatorWidget: const Divider(),
            scrollPhysics: const BouncingScrollPhysics(),
            horizontalScrollPhysics: const BouncingScrollPhysics(),
          ),
          error: (error, stackTrace) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: 1450,
            itemCount: 0,
            isFixedHeader: true,
            leftHandSideColBackgroundColor: CBColors.backgroundColor,
            rightHandSideColBackgroundColor: CBColors.backgroundColor,
            headerWidgets: [
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'N°',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Photo',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Nom',
                  familyName: 'collectors',
                  searchProvider: searchProvider('agents-name'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Prénoms',
                  familyName: 'agents-firstnames',
                  searchProvider: searchProvider('agents-firstnames'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Email',
                  familyName: 'agents-email',
                  searchProvider: searchProvider('agents-email'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Téléphone',
                  familyName: 'agents-phoneNumber',
                  searchProvider: searchProvider('agents-phoneNumber'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Adresse',
                  familyName: 'agents-address',
                  searchProvider: searchProvider('agents-address'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Rôle',
                  familyName: 'agents-role',
                  searchProvider: searchProvider('agents-role'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
            ],
            leftSideItemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                width: 200.0,
                height: 30.0,
                child: CBText(
                  text: '${index + 1}',
                  fontSize: 12.0,
                ),
              );
            },
            rightSideItemBuilder: (BuildContext context, int index) {
              return const Row(
                children: [],
              );
            },
            rowSeparatorWidget: const Divider(),
            scrollPhysics: const BouncingScrollPhysics(),
            horizontalScrollPhysics: const BouncingScrollPhysics(),
          ),
          loading: () => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: 1450,
            itemCount: 0,
            isFixedHeader: true,
            leftHandSideColBackgroundColor: CBColors.backgroundColor,
            rightHandSideColBackgroundColor: CBColors.backgroundColor,
            headerWidgets: [
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'N°',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Photo',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Nom',
                  familyName: 'collectors',
                  searchProvider: searchProvider('agents-name'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Prénoms',
                  familyName: 'agents-firstnames',
                  searchProvider: searchProvider('agents-firstnames'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Email',
                  familyName: 'agents-email',
                  searchProvider: searchProvider('agents-email'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Téléphone',
                  familyName: 'agents-phoneNumber',
                  searchProvider: searchProvider('agents-phoneNumber'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Adresse',
                  familyName: 'agents-address',
                  searchProvider: searchProvider('agents-address'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Rôle',
                  familyName: 'agents-role',
                  searchProvider: searchProvider('agents-role'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
            ],
            leftSideItemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                width: 200.0,
                height: 30.0,
                child: CBText(
                  text: '${index + 1}',
                  fontSize: 12.0,
                ),
              );
            },
            rightSideItemBuilder: (BuildContext context, int index) {
              return const Row(
                children: [],
              );
            },
            rowSeparatorWidget: const Divider(),
            scrollPhysics: const BouncingScrollPhysics(),
            horizontalScrollPhysics: const BouncingScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
