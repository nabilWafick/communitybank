import 'package:communitybank/controllers/customer_account/customer_account.controller.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/data/customer_account_detail/customer_account_detail.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/cash/cash_operations/search_options/search_options.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchedCustomersAccountsDetailsProvider =
    StateProvider<List<CustomerAccountDetail>>((ref) {
  return [];
});

final selectedCustomerAccountDetailProvider =
    StateProvider<CustomerAccountDetail?>((ref) {
  return;
});

class CBCashOperationsCustomerAccountSearchInput
    extends StatefulHookConsumerWidget {
  const CBCashOperationsCustomerAccountSearchInput({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CBCashOperationsCustomerAccountSearchInputState();
}

class _CBCashOperationsCustomerAccountSearchInputState
    extends ConsumerState<CBCashOperationsCustomerAccountSearchInput> {
  final focusNode = FocusNode();
  final layerLink = LayerLink();
  late TextEditingController controller;
  OverlayEntry? entry;

  @override
  void initState() {
    controller = TextEditingController();

    focusNode.addListener(
      () {
        if (focusNode.hasFocus) {
          showOverlay();
        } else {
          hideOverlay();
        }
      },
    );

    super.initState();
  }

  showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    entry = OverlayEntry(
      builder: (context) => CompositedTransformFollower(
        link: layerLink,
        showWhenUnlinked: false,
        offset: Offset(
          0,
          size.height + 3,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchedCustomersAccountsOverlay(
              width: size.width,
              focusNode: focusNode,
              hideOverlay: hideOverlay,
            ),
          ],
        ),
      ),
    );

    overlay.insert(entry!);
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      selectedCustomerAccountDetailProvider,
      (previous, next) {
        Future.delayed(
          const Duration(
            milliseconds: 100,
          ),
          () {
            controller.text = next!.customer;
            // update the provider
            ref
                .read(cashOperationsSelectedCustomerAccountProvider.notifier)
                .state = CustomerAccount(
              customerId: next.customerId,
              collectorId: next.collectorId,
              customerCardsIds: next.cardsIds,
              createdAt: next.createdAt,
              updatedAt: next.updatedAt,
            );

            ref.read(isRefreshingProvider.notifier).state = false;

            ref
                .read(
                  showAllCustomerCardsProvider.notifier,
                )
                .state = false;
          },
        );
      },
    );

    return SizedBox(
      width: 300.0,
      child: Column(
        children: [
          CompositedTransformTarget(
            link: layerLink,
            child: TextFormField(
              controller: controller,
              style: const TextStyle(
                fontSize: 12.0,
              ),
              decoration: InputDecoration(
                label: const CBText(
                  text: 'Client',
                  fontSize: 10.0,
                ),
                hintText: 'Client',
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.text = '';
                  },
                  icon: const Icon(
                    Icons.clear,
                    size: 20.0,
                    color: CBColors.primaryColor,
                  ),
                ),
              ),
              //  onTap: () => showOverlay(),
              onChanged: (value) async {
                if (value == '') {
                  value = '@#%*=+*';
                }

                ref
                        .read(searchedCustomersAccountsDetailsProvider.notifier)
                        .state =
                    await CustomersAccountsController.searchCustomerAccount(
                  name: value.trim(),
                );

                hideOverlay();
                showOverlay();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchedCustomersAccountsOverlay extends StatefulHookConsumerWidget {
  final double width;
  final FocusNode focusNode;
  final void Function() hideOverlay;

  const SearchedCustomersAccountsOverlay({
    super.key,
    required this.width,
    required this.focusNode,
    required this.hideOverlay,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchedCustomersAccountsOverlayState();
}

class _SearchedCustomersAccountsOverlayState
    extends ConsumerState<SearchedCustomersAccountsOverlay> {
  @override
  Widget build(BuildContext context) {
    final searchedCustomersAccounts =
        ref.watch(searchedCustomersAccountsDetailsProvider);
    return searchedCustomersAccounts.isNotEmpty
        ? Card(
            //  shape: const BeveledRectangleBorder(),
            elevation: 5.0,
            margin: const EdgeInsets.all(.0),
            color: CBColors.backgroundColor,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: widget.width,
                maxHeight: 500.0,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: searchedCustomersAccounts
                      .map(
                        (customerAccountData) => ListTile(
                          onTap: () {
                            ref
                                .read(selectedCustomerAccountDetailProvider
                                    .notifier)
                                .state = customerAccountData;

                            widget.focusNode.unfocus();
                            widget.hideOverlay();
                          },
                          title: Container(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                            ),
                            child: CBText(
                              text: customerAccountData.customer,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
