import 'package:communitybank/controllers/forms/on_changed/collection/collection.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/collection/collection.validator.dart';
import 'package:communitybank/functions/crud/collections/collections_crud.function.dart';
import 'package:communitybank/models/data/collection/collection.model.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CollectionAmountUpdateForm extends StatefulHookConsumerWidget {
  final Collection collection;
  const CollectionAmountUpdateForm({
    super.key,
    required this.collection,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectionAmountUpdateFormState();
}

class _CollectionAmountUpdateFormState
    extends ConsumerState<CollectionAmountUpdateForm> {
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
                        text: 'Collecte',
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
                  const SizedBox(
                    height: 35.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: .0,
                        ),
                        width: formCardWidth,
                        child: const CBTextFormField(
                          label: 'Montant',
                          hintText: 'Montant à complèter',
                          isMultilineTextForm: false,
                          obscureText: false,
                          textInputType: TextInputType.number,
                          validator: CollectionValidors.collectionAmount,
                          onChanged: CollectionOnChanged.collectionAmount,
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
                            onPressed: () async {
                              CollectionCRUDFunctions.updateCollectionAmount(
                                context: context,
                                formKey: formKey,
                                ref: ref,
                                collection: widget.collection,
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
