import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/customers/customers_list/customers_list.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CashOperationsCustomerProfil extends ConsumerWidget {
  final Customer? customer;
  const CashOperationsCustomerProfil({super.key, this.customer});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customersListStream = ref.watch(customersListStreamProvider);
    return customer != null
        ? Consumer(
            builder: (context, ref, child) => customersListStream.when(
              data: (data) {
                final realTimeCustomerData = data.firstWhere(
                  (customerData) => customer!.id == customerData.id,
                );

                return Row(
                  children: [
                    Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          50.0,
                        ),
                        border: Border.all(
                          color: CBColors.sidebarTextColor.withOpacity(.5),
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: realTimeCustomerData.profile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  50.0,
                                ),
                                child: Image.network(
                                  realTimeCustomerData.profile!,
                                ),
                              )
                            : const Center(
                                child: Icon(
                                  Icons.person,
                                  size: 30.0,
                                  color: CBColors.primaryColor,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CBText(
                          text: FunctionsController.truncateText(
                            text:
                                '${realTimeCustomerData.name} ${realTimeCustomerData.firstnames}',
                            maxLength: 15,
                          ),
                          fontWeight: FontWeight.w500,
                          fontSize: 11.0,
                        ),
                        CBText(
                          text: realTimeCustomerData.phoneNumber,
                          fontSize: 10.0,
                        ),
                      ],
                    ),
                  ],
                );
              },
              error: (error, stackTrace) => Row(
                children: [
                  Container(
                    height: 80.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        50.0,
                      ),
                      border: Border.all(
                        color: CBColors.sidebarTextColor.withOpacity(.5),
                        width: 1.5,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 30.0,
                        color: CBColors.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CBText(
                        text: '',
                        fontWeight: FontWeight.w500,
                        fontSize: 11.0,
                      ),
                      CBText(
                        text: '',
                        fontSize: 10.0,
                      ),
                    ],
                  ),
                ],
              ),
              loading: () => Row(
                children: [
                  Container(
                    height: 80.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        50.0,
                      ),
                      border: Border.all(
                        color: CBColors.sidebarTextColor.withOpacity(.5),
                        width: 1.5,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 30.0,
                        color: CBColors.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CBText(
                        text: '',
                        fontWeight: FontWeight.w500,
                        fontSize: 11.0,
                      ),
                      CBText(
                        text: '',
                        fontSize: 10.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Row(
            children: [
              Container(
                height: 80.0,
                width: 80.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    50.0,
                  ),
                  border: Border.all(
                    color: CBColors.sidebarTextColor.withOpacity(.5),
                    width: 1.5,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    size: 30.0,
                    color: CBColors.primaryColor,
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CBText(
                    text: '',
                    fontWeight: FontWeight.w500,
                    fontSize: 11.0,
                  ),
                  CBText(
                    text: '',
                    fontSize: 10.0,
                  ),
                ],
              ),
            ],
          );
  }
}
