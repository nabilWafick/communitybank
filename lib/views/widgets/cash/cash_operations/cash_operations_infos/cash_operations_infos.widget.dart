import 'package:communitybank/views/widgets/cash/cash_operations/cash_operations_infos/cash_operations_customer_card_infos/cash_operations_customer_card_infos.widget.dart';
import 'package:communitybank/views/widgets/cash/cash_operations/cash_operations_infos/cash_operations_customer_infos/cash_operations_customer_infos.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CashOperationsInfos extends ConsumerWidget {
  const CashOperationsInfos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      //  color: Colors.blueGrey,
      height: 340.0,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CashOperationsCustomerInfos(
              width: width / 3.15,
            ),
            CashOperationsCustomerCardInfos(
              width: width * 1.543 / 3,
            ),
          ],
        ),
      ),
    );
  }
}
