import 'package:communitybank/models/data/transfer_detail/transfer_detail.model.dart';
import 'package:communitybank/services/transfers_details/transfers_details.service.dart';

class TransfersDetailsController {
  static Future<List<TransferDetail>> getTransfersDetails({
    required int? agentId,
    required String? validationDate,
    required String? creationDate,
    required int? issuingCustomerCardId,
    required int? issuingCustomerCardTypeId,
    required int? issuingCustomerAccountId,
    required int? issuingCustomerCollectorId,
    required int? receivingCustomerCardId,
    required int? receivingCustomerCardTypeId,
    required int? receivingCustomerAccountId,
    required int? receivingCustomerCollectorId,
  }) async {
    final transfersDetails = await TransfersDetailsService.getTransfersDetails(
      agentId: agentId,
      validationDate: validationDate,
      creationDate: creationDate,
      issuingCustomerCardId: issuingCustomerCardId,
      issuingCustomerCardTypeId: issuingCustomerCardTypeId,
      issuingCustomerAccountId: issuingCustomerAccountId,
      issuingCustomerCollectorId: issuingCustomerCollectorId,
      receivingCustomerCardId: receivingCustomerCardId,
      receivingCustomerCardTypeId: receivingCustomerCardTypeId,
      receivingCustomerAccountId: receivingCustomerAccountId,
      receivingCustomerCollectorId: receivingCustomerCollectorId,
    );

    return transfersDetails.map(
      (transferDetail) {
        return TransferDetail.fromMap(
          transferDetail,
        );
      },
    ).toList();
  }
}
