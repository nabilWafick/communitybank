import 'package:communitybank/controllers/forms/validators/customer_account/customer_account.validator.dart';
import 'package:communitybank/functions/crud/customers_accounts/customers_accounts_crud.fuction.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/definitions/collectors/collectors_list/collectors_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers/customers_list/customers_list.widget.dart';
import 'package:communitybank/views/widgets/globals/customer_account_owner_card_selection/customer_account_owner_card_selection.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/customer_dropdown/customer_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomerAccountAddingForm extends StatefulHookConsumerWidget {
  const CustomerAccountAddingForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerAccountAddingFormState();
}

class _CustomerAccountAddingFormState
    extends ConsumerState<CustomerAccountAddingForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    final customersListStream = ref.watch(customersListStreamProvider);
    final collectorsListStream = ref.watch(collectorsListStreamProvider);
    const formCardWidth = 500.0;
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      content: SingleChildScrollView(
        child: Container(
          // color: Colors.blueGrey,
          padding: const EdgeInsets.all(20.0),
          width: formCardWidth,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CBText(
                          text: 'Compte Client',
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
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                            right: 15.0,
                          ),
                          width: formCardWidth / 1.2,
                          child: CBFormCustomerDropdown(
                            width: formCardWidth / 1.2,
                            label: 'Client',
                            providerName: 'customer-account-adding-customer',
                            dropdownMenuEntriesLabels: customersListStream.when(
                              data: (data) => data,
                              error: (error, stackTrace) => [],
                              loading: () => [],
                            ),
                            dropdownMenuEntriesValues: customersListStream.when(
                              data: (data) => data,
                              error: (error, stackTrace) => [],
                              loading: () => [],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                            right: 15.0,
                          ),
                          width: formCardWidth / 1.2,
                          child: CBFormCollectorDropdown(
                            width: formCardWidth / 1.2,
                            label: 'Chargé de compte',
                            providerName: 'customer-account-adding-collector',
                            dropdownMenuEntriesLabels:
                                collectorsListStream.when(
                              data: (data) => data,
                              error: (error, stackTrace) => [],
                              loading: () => [],
                            ),
                            dropdownMenuEntriesValues:
                                collectorsListStream.when(
                              data: (data) => data,
                              error: (error, stackTrace) => [],
                              loading: () => [],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CBText(
                            text: 'Cartes',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                          CBAddButton(
                            onTap: () {
                              ref
                                  .read(customerAccountAddedInputsProvider
                                      .notifier)
                                  .update((state) {
                                return {
                                  ...state,
                                  DateTime.now().millisecondsSinceEpoch: true,
                                };
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Consumer(builder: (context, ref, child) {
                      final inputsMaps =
                          ref.watch(customerAccountAddedInputsProvider);
                      List<Widget> inputsWidgetsList = [];

                      for (MapEntry mapEntry in inputsMaps.entries) {
                        inputsWidgetsList.add(
                          CustomerAccountOwnerCardSelection(
                            index: mapEntry.key,
                            isVisible: mapEntry.value,
                            customerCardDropdownProvider:
                                'customer-account-selection-adding-customer-card-${mapEntry.key}',
                            formCardWidth: formCardWidth,
                          ),
                        );
                      }

                      return Wrap(
                        children: inputsWidgetsList,
                      );
                    }),
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
                                CustomerAccountCRUDFunctions.create(
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
      ),
    );
  }
}
