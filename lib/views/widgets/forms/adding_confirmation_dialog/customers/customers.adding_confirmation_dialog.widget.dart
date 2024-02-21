import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomerAddingConfirmationDialog extends StatefulHookConsumerWidget {
  final GlobalKey<FormState> formKey;
  final List<Customer> similarCustomers;
  final ValueNotifier<bool> showValidatedButton;
  final BuildContext context;
  final Future<void> Function({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) confirmToAdd;
  const CustomerAddingConfirmationDialog({
    super.key,
    required this.formKey,
    required this.similarCustomers,
    required this.context,
    required this.showValidatedButton,
    required this.confirmToAdd,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerAddingConfirmationDialogState();
}

class _CustomerAddingConfirmationDialogState
    extends ConsumerState<CustomerAddingConfirmationDialog> {
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    const formCardWidth = 500.0;
    final showConfirmationButton = useState<bool>(true);
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      content: Container(
        // color: Colors.blueGrey,
        padding: const EdgeInsets.all(20.0),
        width: formCardWidth,
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
                      text: 'Confirmation',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                    IconButton(
                      onPressed: () {
                        widget.showValidatedButton.value = true;
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
                    vertical: 25.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: Colors.orange[900],
                            size: 30.0,
                          ),
                          const SizedBox(
                            width: 25.0,
                          ),
                          const Flexible(
                            child: CBText(
                              text: 'Ce client est peût être dejà enregistré \n'
                                  'Vérifiez les ressemblences et confirmez',
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20.0,
                        ),
                        height: 200,
                        width: formCardWidth * .8,
                        child: Scrollbar(
                          controller: scrollController,
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.similarCustomers
                                  .map(
                                    (similarCustomer) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5.0,
                                      ),
                                      child: CBText(
                                        text:
                                            '${similarCustomer.name} ${similarCustomer.firstnames}',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 170.0,
                  child: CBElevatedButton(
                    text: 'Annuler',
                    backgroundColor: CBColors.sidebarTextColor,
                    onPressed: () {
                      widget.showValidatedButton.value = true;
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                showConfirmationButton.value
                    ? SizedBox(
                        width: 170.0,
                        child: CBElevatedButton(
                          text: 'Confirmer',
                          onPressed: () async {
                            showConfirmationButton.value = false;
                            widget.confirmToAdd(
                              context: widget.context,
                              formKey: widget.formKey,
                              ref: ref,
                              showValidatedButton: widget.showValidatedButton,
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
    );
  }
}
