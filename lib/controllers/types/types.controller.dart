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

  static Stream<List<Type>> getAll({
    // required StreamProviderRef<List<Type>> ref,
    required String selectedTypeStake,
    required int? selectedProductId,
  }) async* {
    //  debugPrint('In Controller');
    Stream<List<Map<String, dynamic>>> typesMapListStream = TypesService.getAll(
      selectedTypeStake:
          selectedTypeStake, /* selectedProductId: selectedProductId*/
    );

    // filter the stream when selectedProductId is not equal to 0 (All products) in order to get only types containing selectedProductId in productsIds
    if (/*selectedProductId != null ||*/ selectedProductId != 0) {
      typesMapListStream = typesMapListStream.map(
        (typesMapList) => typesMapList
            .where(
              (typeMap) =>
                  typeMap[TypeTable.productsIds].contains(selectedProductId),
            )
            .toList(),
      );
    }

    Stream<List<Type>> typesListStream = typesMapListStream.map(
      (typesMapList) => typesMapList.map(
        (typeMap) {
          return Type.fromMap(typeMap);
        },
      ).toList(),
    );

    yield* typesListStream;
  }

  static Future<List<Type>> searchType({required String name}) async {
    List<Map<String, dynamic>> searchedTypesMap =
        await TypesService.searchType(name: name);

    return searchedTypesMap.map(
      (typeMap) {
        return Type(
          id: typeMap[TypeTable.id]?.toInt() ?? 0,
          name: typeMap[TypeTable.name],
          stake: typeMap[TypeTable.stake]?.toDouble() ?? .0,
          products: [],
          productsIds: typeMap[TypeTable.productsIds],
          productsNumber: typeMap[TypeTable.productsNumbers],
          createdAt: DateTime.parse(typeMap[TypeTable.createdAt]),
          updatedAt: DateTime.parse(typeMap[TypeTable.createdAt]),
        );
      },
    ).toList();
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
