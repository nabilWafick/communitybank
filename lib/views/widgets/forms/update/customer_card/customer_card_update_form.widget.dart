import 'package:communitybank/controllers/forms/on_changed/customer_card/customer_card.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/customer_card/customer_card.validator.dart';
import 'package:communitybank/functions/crud/customer_card/customer_card_crud.fuction.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/type/type_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomerCardUpdateForm extends StatefulHookConsumerWidget {
  final CustomerCard customerCard;
  const CustomerCardUpdateForm({super.key, required this.customerCard});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerCardUpdateFormState();
}

class _CustomerCardUpdateFormState
    extends ConsumerState<CustomerCardUpdateForm> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      ref.read(isCustomerCardSatisfiedProvider.notifier).state =
          widget.customerCard.satisfiedAt != null;

      ref.read(isCustomerCardRepaidProvider.notifier).state =
          widget.customerCard.repaidAt != null;

      ref.read(customerCardSatisfactionDateProvider.notifier).state =
          widget.customerCard.satisfiedAt;

      ref.read(customerCardRepaymentDateProvider.notifier).state =
          widget.customerCard.repaidAt;
    });
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    final typeListStream = ref.watch(typesListStreamProvider);
    final isSatisfied = ref.watch(isCustomerCardSatisfiedProvider);
    final isRepaid = ref.watch(isCustomerCardRepaidProvider);
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
                        text: 'Cartes Clients',
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
                  Wrap(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        width: formCardWidth,
                        child: const CBTextFormField(
                          label: 'Libellé',
                          hintText: 'Libellé',
                          isMultilineTextForm: false,
                          obscureText: false,
                          textInputType: TextInputType.name,
                          validator: CustomerCardValidators.customerCardLabel,
                          onChanged: CustomerCardOnChanged.customerCardLabel,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                          right: 50.0,
                          left: 10.0,
                        ),
                        width: formCardWidth / 1.16,
                        child: CBFormTypeDropdown(
                          width: formCardWidth / 1.16,
                          label: 'Type',
                          providerName: 'customer-card-adding-type',
                          dropdownMenuEntriesLabels: typeListStream.when(
                            data: (data) => data,
                            error: (error, stackTrace) => [],
                            loading: () => [],
                          ),
                          dropdownMenuEntriesValues: typeListStream.when(
                            data: (data) => data,
                            error: (error, stackTrace) => [],
                            loading: () => [],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SwitchListTile(
                    value: isRepaid,
                    title: const CBText(
                      text: 'Remboursé',
                    ),
                    onChanged: (value) {
                      isSatisfied == false
                          ? ref
                              .read(isCustomerCardRepaidProvider.notifier)
                              .state = value
                          : () {};
                    },
                  ),
                  SwitchListTile(
                    value: isSatisfied,
                    title: const CBText(
                      text: 'Satisfait',
                    ),
                    onChanged: (value) {
                      isRepaid == false
                          ? ref
                              .read(isCustomerCardSatisfiedProvider.notifier)
                              .state = value
                          : () {};
                    },
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
                              CustomerCardCRUDFunctions.create(
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
