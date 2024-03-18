import 'package:communitybank/models/data/settlement/settlement.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/services/settlements/settlements.service.dart';

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

  static Stream<List<Settlement>> getAll(
      {required int? customerCardId}) async* {
    final settlementsMapListStream = SettlementsService.getAll(
      customerCardId: customerCardId,
    );

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
