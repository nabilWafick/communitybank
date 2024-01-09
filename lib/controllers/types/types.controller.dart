import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/models/tables/type/type_table.model.dart';
import 'package:communitybank/services/types/types.service.dart';

class TypesController {
  static Future<ServiceResponse> create({required Type type}) async {
    final response = await TypesService.create(type: type);
    // return response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<Type?> getOne({required int id}) async {
    final response = await TypesService.getOne(id: id);
    // return the specific Type data or null
    return response == null ? null : Type.fromMap(response);
  }

  static Stream<List<Type>> getAll(
      {required double selectedTypeStake, required int productId}) async* {
    final typesMapListStream = TypesService.getAll(
        selectedTypeStake: selectedTypeStake, productId: productId);

    // yield all types data or an empty list
    yield* typesMapListStream.map(
      (typesMapList) => typesMapList
          .map(
            (typeMap) => Type.fromMap(typeMap),
          )
          .toList(),
    );
    //.asBroadcastStream();
  }

  static Future<List<Type>> searchType({required String name}) async {
    final searchedTypes = await TypesService.searchType(name: name);

    return searchedTypes
        .map(
          (typeMap) => Type.fromMap(typeMap),
        )
        .toList();
  }

  static Stream<List<double>> getAllTypesStakes() async* {
    final typesStakesStream = TypesService.getAllTypesStakes();

    yield* typesStakesStream.map(
      (typesStakes) => typesStakes
          .map((typeStake) => typeStake[TypeTable.stake] as double)
          .toList(),
    );
  }

  static Future<ServiceResponse> update(
      {required int id, required Type type}) async {
    final response = await TypesService.update(
      id: id,
      type: type,
    );
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<ServiceResponse> delete({required Type type}) async {
    final response = await TypesService.delete(type: type);
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }
}
