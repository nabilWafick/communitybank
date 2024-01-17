import 'package:communitybank/controllers/forms/on_changed/agent/agent.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/agent/agent.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/agents/agent_crud.function.dart';
import 'package:communitybank/models/data/agent_role/agent_role.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgentAddingForm extends StatefulHookConsumerWidget {
  const AgentAddingForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AgentAddingFormState();
}

class _AgentAddingFormState extends ConsumerState<AgentAddingForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const formCardWidth = 700.0;
    final showValidatedButton = useState<bool>(true);
    final agentPicture = ref.watch(agentPictureProvider);
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      content: Container(
        // color: Colors.blueGrey,
        padding: const EdgeInsets.all(20.0),
        width: formCardWidth,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CBText(
                        text: 'Agent',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          color: CBColors.primaryColor,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 15.0,
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 25.0,
                            horizontal: 55.0,
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15.0),
                          //width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CBColors.sidebarTextColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                            shape: BoxShape.rectangle,
                          ),
                          child: InkWell(
                            onTap: () async {
                              final imageFromGallery =
                                  await FunctionsController.pickFile();
                              ref.read(agentPictureProvider.notifier).state =
                                  imageFromGallery;
                            },
                            child: Center(
                              child: agentPicture == null
                                  ? const Icon(
                                      Icons.photo,
                                      size: 150.0,
                                      color: CBColors.primaryColor,
                                    )
                                  : Image.asset(
                                      agentPicture,
                                      height: 250.0,
                                      width: 250.0,
                                    ),
                            ),
                          ),
                        ),
                        const CBText(
                          text: 'Profil',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        width: formCardWidth / 2.3,
                        child: const CBTextFormField(
                          label: 'Nom',
                          hintText: 'Nom',
                          isMultilineTextForm: false,
                          obscureText: false,
                          textInputType: TextInputType.name,
                          validator: AgentValidators.agentName,
                          onChanged: AgentOnChanged.agentName,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        width: formCardWidth / 2.3,
                        child: const CBTextFormField(
                          label: 'Prénoms',
                          hintText: 'Prénoms',
                          isMultilineTextForm: false,
                          obscureText: false,
                          textInputType: TextInputType.name,
                          validator: AgentValidators.agentFirstnames,
                          onChanged: AgentOnChanged.agentFirstnames,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        width: formCardWidth / 2.3,
                        child: const CBTextFormField(
                          label: 'Téléphone',
                          hintText: '+229|00229--------',
                          isMultilineTextForm: false,
                          obscureText: false,
                          textInputType: TextInputType.name,
                          validator: AgentValidators.agentPhoneNumber,
                          onChanged: AgentOnChanged.agentPhoneNumber,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        width: formCardWidth / 2.3,
                        child: const CBTextFormField(
                          label: 'Adresse',
                          hintText: 'Adresse',
                          isMultilineTextForm: false,
                          obscureText: false,
                          textInputType: TextInputType.name,
                          validator: AgentValidators.agentAddress,
                          onChanged: AgentOnChanged.agentAddress,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          width: formCardWidth / 2.3,
                          child: const CBFormStringDropdown(
                            width: formCardWidth / 2.3,
                            label: 'Role',
                            providerName: 'agent-adding-role',
                            dropdownMenuEntriesLabels: [
                              AgentRole.simpleUser,
                              AgentRole.semiAdmin,
                              AgentRole.admin
                            ],
                            dropdownMenuEntriesValues: [
                              AgentRole.simpleUser,
                              AgentRole.semiAdmin,
                              AgentRole.admin
                            ],
                          )),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 35.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 170.0,
                    child: CBElevatedButton(
                      text: 'Fermer',
                      backgroundColor: CBColors.sidebarTextColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  showValidatedButton.value
                      ? SizedBox(
                          width: 170.0,
                          child: CBElevatedButton(
                            text: 'Valider',
                            onPressed: () {
                              AgentCRUDFunctions.create(
                                context: context,
                                formKey: formKey,
                                ref: ref,
                                showValidatedButton: showValidatedButton,
                              );
                            },
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
