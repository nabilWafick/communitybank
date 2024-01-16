import 'package:communitybank/models/data/settlement/settlement.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/services/settlement/settlement.service.dart';

class SettlementsController {
  static Future<ServiceResponse> create(
      {required Settlement settlement}) async {
    final response = await SettlementsService.create(settlement: settlement);
    // return response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<Settlement?> getOne({required int id}) async {
    final response = await SettlementsService.getOne(id: id);
    // return the specific Settlement data or null
    return response == null ? null : Settlement.fromMap(response);
  }

  static Stream<List<Settlement>> getAll() async* {
    final settlementsMapListStream = SettlementsService.getAll();

    // yield all Settlements data or an empty list
    yield* settlementsMapListStream.map(
      (settlementsMapList) => settlementsMapList
          .map(
            (settlementMap) => Settlement.fromMap(settlementMap),
          )
          .toList(),
    );
    //.asBroadcastStream();
  }

/*
  static Future<List<Settlement>> searchSettlement({required String name}) async {
    final searchedSettlements = await SettlementsService.searchSettlement(name: name);

    return searchedSettlements
        .map(
          (SettlementMap) => Settlement.fromMap(SettlementMap),
        )
        .toList();
  }
  */

  static Future<ServiceResponse> update(
      {required int id, required Settlement settlement}) async {
    final response = await SettlementsService.update(
      id: id,
      settlement: settlement,
    );
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<ServiceResponse> delete(
      {required Settlement settlement}) async {
    final response = await SettlementsService.delete(settlement: settlement);
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }
}
