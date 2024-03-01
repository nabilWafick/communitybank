import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/customers_products/customers_products.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomersProductsDetailsShower extends ConsumerWidget {
  final CustomersProducts customersProducts;
  const CustomersProductsDetailsShower({
    super.key,
    required this.customersProducts,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      text: FunctionsController.truncateText(
                        text: customersProducts.productName,
                        maxLength: 27,
                      ),
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
                    itemCount: customersProducts.customersIds.length,
                    itemBuilder: (context, index) {
                      if (customersProducts.customers[index] != null) {
                        return ListTile(
                          title: CBText(
                            text: '${customersProducts.customers[index]}',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.left,
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
