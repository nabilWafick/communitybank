import 'package:communitybank/controllers/forms/on_changed/collection/collection.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/collection/collection.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/collections/collections_crud.function.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/definitions/collectors/collectors.widgets.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class CollectionAddingForm extends StatefulHookConsumerWidget {
  const CollectionAddingForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectionAddingFormState();
}

class _CollectionAddingFormState extends ConsumerState<CollectionAddingForm> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    initializeDateFormatting('fr');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    const formCardWidth = 500.0;
    final collectionDate = ref.watch(collectionDateProvider);

    final format = DateFormat.yMMMMEEEEd('fr');

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
                        width: formCardWidth / 1.15,
                        margin: const EdgeInsets.only(
                          //  horizontal: 10.0,
                          top: 10.0,
                          bottom: 10.0,
                          right: 10.0,
                        ),
                        child: Consumer(
                          builder: (context, ref, child) {
                            final collectorsListStream =
                                ref.watch(collectorsListStreamProvider);

                            return collectorsListStream.when(
                              data: (data) => CBFormCollectorDropdown(
                                width: formCardWidth / 1.15,
                                menuHeigth: 500.0,
                                label: 'Chargé de compte',
                                providerName: 'collection-adding-collector',
                                dropdownMenuEntriesLabels: data,
                                dropdownMenuEntriesValues: data,
                              ),
                              error: (error, stackTrace) =>
                                  const CBFormCollectorDropdown(
                                label: 'Chargé de compte',
                                providerName: 'collection-adding-collector',
                                dropdownMenuEntriesLabels: [],
                                dropdownMenuEntriesValues: [],
                              ),
                              loading: () => const CBFormCollectorDropdown(
                                label: 'Chargé de compte',
                                providerName: 'collection-adding-collector',
                                dropdownMenuEntriesLabels: [],
                                dropdownMenuEntriesValues: [],
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: .0,
                        ),
                        width: formCardWidth,
                        child: const CBTextFormField(
                          label: 'Montant',
                          hintText: 'Montant',
                          isMultilineTextForm: false,
                          obscureText: false,
                          textInputType: TextInputType.number,
                          validator: CollectionValidors.collectionAmount,
                          onChanged: CollectionOnChanged.collectionAmount,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 15.0,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CBIconButton(
                              icon: Icons.date_range,
                              text: 'Date de Collecte',
                              onTap: () {
                                FunctionsController.showDateTime(
                                  context,
                                  ref,
                                  collectionDateProvider,
                                );
                              },
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Flexible(
                              child: CBText(
                                text: collectionDate != null
                                    ? '${format.format(collectionDate)}  ${collectionDate.hour}:${collectionDate.minute}'
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
                              CollectionCRUDFunctions.create(
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
