import 'package:communitybank/functions/crud/customers_accounts/customers_accounts_crud.fuction.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/definitions/collectors/collectors_list/collectors_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers/customers_list/customers_list.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/customer_dropdown/customer_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomerAccountUpdateForm extends StatefulHookConsumerWidget {
  final CustomerAccount customerAccount;
  const CustomerAccountUpdateForm({
    super.key,
    required this.customerAccount,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerAccountUpdateFormState();
}

class _CustomerAccountUpdateFormState
    extends ConsumerState<CustomerAccountUpdateForm> {
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
                        text: 'Localité',
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
                        child: CBFormCustomerDropdown(
                          width: formCardWidth,
                          label: 'Client',
                          providerName: 'customer-account-update-customer',
                          dropdownMenuEntriesLabels: customersListStream.when(
                            data: (data) {
                              final customerAccountOwner = data.firstWhere(
                                (customer) =>
                                    customer.id ==
                                    widget.customerAccount.customerId,
                              );
                              data.remove(customerAccountOwner);
                              data = [customerAccountOwner, ...data];
                              return data;
                            },
                            error: (error, stackTrace) => [],
                            loading: () => [],
                          ),
                          dropdownMenuEntriesValues: customersListStream.when(
                            data: (data) {
                              final customerAccountOwner = data.firstWhere(
                                (customer) =>
                                    customer.id ==
                                    widget.customerAccount.customerId,
                              );
                              data.remove(customerAccountOwner);
                              data = [customerAccountOwner, ...data];

                              return data;
                            },
                            error: (error, stackTrace) => [],
                            loading: () => [],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        width: formCardWidth,
                        child: CBFormCollectorDropdown(
                          width: formCardWidth,
                          label: 'Collector',
                          providerName: 'customer-account-update-collector',
                          dropdownMenuEntriesLabels: collectorsListStream.when(
                            data: (data) {
                              final customerAccountCollector = data.firstWhere(
                                (collector) =>
                                    collector.id ==
                                    widget.customerAccount.collectorId,
                              );
                              data.remove(customerAccountCollector);
                              data = [customerAccountCollector, ...data];
                              return data;
                            },
                            error: (error, stackTrace) => [],
                            loading: () => [],
                          ),
                          dropdownMenuEntriesValues: collectorsListStream.when(
                            data: (data) {
                              final customerAccountCollector = data.firstWhere(
                                (collector) =>
                                    collector.id ==
                                    widget.customerAccount.collectorId,
                              );
                              data.remove(customerAccountCollector);
                              data = [customerAccountCollector, ...data];
                              return data;
                            },
                            error: (error, stackTrace) => [],
                            loading: () => [],
                          ),
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
    );
  }
}
