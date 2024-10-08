import 'package:communitybank/controllers/forms/on_changed/collector/collector.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/collector/collector.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/collectors/collectors_crud.function.dart';
import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CollectorUpdateForm extends StatefulHookConsumerWidget {
  final Collector collector;
  const CollectorUpdateForm({
    super.key,
    required this.collector,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectorUpdateFormState();
}

class _CollectorUpdateFormState extends ConsumerState<CollectorUpdateForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const formCardWidth = 700.0;
    final showValidatedButton = useState<bool>(true);
    final collectorPicture = ref.watch(collectorPictureProvider);
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
                        text: 'Chargé de compte',
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
                              ref
                                  .read(collectorPictureProvider.notifier)
                                  .state = imageFromGallery;
                            },
                            child: Center(
                              child: collectorPicture == null &&
                                      widget.collector.profile != null
                                  ? Image.network(
                                      widget.collector.profile!,
                                      height: 250.0,
                                      width: 250.0,
                                    )
                                  : collectorPicture == null
                                      ? const Icon(
                                          Icons.photo,
                                          size: 150.0,
                                          color: CBColors.primaryColor,
                                        )
                                      : Image.asset(
                                          collectorPicture,
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
                        child: CBTextFormField(
                          label: 'Nom',
                          hintText: 'Nom',
                          initialValue: widget.collector.name,
                          isMultilineTextForm: false,
                          obscureText: false,
                          textInputType: TextInputType.name,
                          validator: CollectorValidators.collectorName,
                          onChanged: CollectorOnChanged.collectorName,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        width: formCardWidth / 2.3,
                        child: CBTextFormField(
                          label: 'Prénoms',
                          hintText: 'Prénoms',
                          initialValue: widget.collector.firstnames,
                          isMultilineTextForm: false,
                          obscureText: false,
                          textInputType: TextInputType.name,
                          validator: CollectorValidators.collectorFirstnames,
                          onChanged: CollectorOnChanged.collectorFirstnames,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        width: formCardWidth / 2.3,
                        child: CBTextFormField(
                          label: 'Téléphone',
                          hintText: '+229|00229________',
                          isMultilineTextForm: false,
                          obscureText: false,
                          initialValue: widget.collector.phoneNumber,
                          textInputType: TextInputType.name,
                          validator: CollectorValidators.collectorPhoneNumber,
                          onChanged: CollectorOnChanged.collectorPhoneNumber,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        width: formCardWidth / 2.3,
                        child: CBTextFormField(
                          label: 'Adresse',
                          hintText: 'Adresse',
                          initialValue: widget.collector.address,
                          isMultilineTextForm: false,
                          obscureText: false,
                          textInputType: TextInputType.name,
                          validator: CollectorValidators.collectorAddress,
                          onChanged: CollectorOnChanged.collectorAddress,
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
                              CollectorCRUDFunctions.update(
                                context: context,
                                formKey: formKey,
                                ref: ref,
                                collector: widget.collector,
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
