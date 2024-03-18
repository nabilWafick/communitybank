import 'package:communitybank/models/data/transfer/transfer.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/services/transfers/transfers.service.dart';

class TransfersController {
  static Future<ServiceResponse> create({
    required Transfer transfer,
  }) async {
    final response = await TransfersService.create(transfer: transfer);
    // return response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<Transfer?> getOne({required int id}) async {
    final response = await TransfersService.getOne(id: id);
    // return the specific transfer data or null
    return response == null ? null : Transfer.fromMap(response);
  }

  static Stream<List<Transfer>> getAll({
    required int? customerAccountId,
    required int? issuingCustomerCardId,
    required int? receivingCustomerCardId,
    required int? agentId,
  }) async* {
    final transfersMapListStream = TransfersService.getAll(
      customerAccountId: customerAccountId,
      issuingCustomerCardId: issuingCustomerCardId,
      receivingCustomerCardId: receivingCustomerCardId,
      agentId: agentId,
    );

    // yield all transfers data or an empty list
    yield* transfersMapListStream.map(
      (transfersMapList) => transfersMapList
          .map(
            (transferMap) => Transfer.fromMap(transferMap),
          )
          .toList(),
    );
    //.asBroadcastStream();
  }

  static Future<ServiceResponse> update({
    required int id,
    required Transfer transfer,
  }) async {
    final response = await TransfersService.update(
      id: id,
      transfer: transfer,
    );
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<ServiceResponse> delete({
    required Transfer transfer,
  }) async {
    final response = await TransfersService.delete(transfer: transfer);
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }
}
