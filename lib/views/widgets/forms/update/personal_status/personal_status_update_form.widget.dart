import 'package:communitybank/controllers/forms/on_changed/personal_status/personal_status.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/personal_status/personal_status.validator.dart';
import 'package:communitybank/functions/crud/personal_status/personal_status_crud.function.dart';
import 'package:communitybank/models/data/personal_status/personal_status.model.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PersonalStatusUpdateForm extends StatefulHookConsumerWidget {
  final PersonalStatus personalStatus;
  const PersonalStatusUpdateForm({
    super.key,
    required this.personalStatus,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PersonalStatusUpdateFormState();
}

class _PersonalStatusUpdateFormState
    extends ConsumerState<PersonalStatusUpdateForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    const formCardWidth = 500.0;
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
                        text: 'Statut Personnel',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                      IconButton(
                        onPressed: () {
                          showValidatedButton.value
                              ? Navigator.of(context).pop()
                              : () {};
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          color: CBColors.primaryColor,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 35.0,
                  ),
                  Wrap(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        width: formCardWidth,
                        child: CBTextFormField(
                          label: 'Nom',
                          hintText: 'Nom',
                          initialValue: widget.personalStatus.name,
                          isMultilineTextForm: false,
                          obscureText: false,
                          textInputType: TextInputType.name,
                          validator:
                              PersonalStatusValidators.personalStatusName,
                          onChanged: PersonalStatusOnChanged.personalStatusName,
                        ),
                      ),
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
                        showValidatedButton.value
                            ? Navigator.of(context).pop()
                            : () {};
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
                            onPressed: () async {
                              PersonalStatusCRUDFunctions.update(
                                context: context,
                                formKey: formKey,
                                ref: ref,
                                personalStatus: widget.personalStatus,
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
