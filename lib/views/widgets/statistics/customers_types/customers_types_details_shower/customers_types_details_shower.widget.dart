import 'package:communitybank/models/data/customers_types/customers_types.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomersTypesDetailsShower extends ConsumerWidget {
  final CustomersTypes customersTypes;
  const CustomersTypesDetailsShower({
    super.key,
    required this.customersTypes,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 700.0;
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
                    CBText(
                      text: customersTypes.typeName,
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
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  height: 550.0,
                  child: ListView.builder(
                    itemCount: customersTypes.customersIds.length,
                    itemBuilder: (context, index) {
                      if (customersTypes.customers[index] != null) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            children: [
                              CBText(
                                text: '${customersTypes.collectors[index]}',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                width: 25.0,
                              ),
                              CBText(
                                text: '${customersTypes.customers[index]}',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                width: 25.0,
                              ),
                              CBText(
                                text:
                                    '${customersTypes.customerCardSettlementsAmounts[index].ceil()}',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 17.0),
              width: 170.0,
              child: CBElevatedButton(
                text: 'Fermer',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
