import 'package:communitybank/models/data/customer_card_settlement_detail/customer_card_settlement_detail.model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomerCardSettlementsDetailsPrinting
    extends StatefulHookConsumerWidget {
  final List<CustomerCardSettlementDetail> customerCardSettlementsDetails;

  const CustomerCardSettlementsDetailsPrinting({
    super.key,
    required this.customerCardSettlementsDetails,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerCardSettlementsDetailsPrintingState();
}

class _CustomerCardSettlementsDetailsPrintingState
    extends ConsumerState<CustomerCardSettlementsDetailsPrinting> {
  @override
  Widget build(BuildContext context) {
    return const AlertDialog();
  }
}
