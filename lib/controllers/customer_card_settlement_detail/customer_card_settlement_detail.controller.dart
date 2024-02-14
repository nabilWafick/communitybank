import 'package:communitybank/models/data/customer_card_settlement_detail/customer_card_settlement_detail.model.dart';
import 'package:communitybank/services/customer_card_settlement_detail/customer_card_settlement_detail.service.dart';

class CustomerCardSettlementsDetailsController {
  static Future<List<CustomerCardSettlementDetail>>
      getCustomerCardSettlementsDetails({
    required int customerCardId,
  }) async {
    final customerCardSettlementsDetails =
        await CustomerCardSettlementsDetailsService
            .getCustomerCardSettlementsDetails(
      customerCardId: customerCardId,
    );

    return customerCardSettlementsDetails
        .map(
          (customerCardSettlementDetailMap) =>
              CustomerCardSettlementDetail.fromMap(
                  customerCardSettlementDetailMap),
        )
        .toList();
  }
}
