import 'package:communitybank/controllers/products/products.controller.dart';
import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/models/tables/product/product_table.model.dart';
import 'package:communitybank/models/tables/type/type_table.model.dart';
import 'package:communitybank/services/types/types.service.dart';
import 'package:flutter/material.dart';

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
      {required String selectedTypeStake /*, required int productId*/}) async* {
    //  debugPrint('In Controller');
    final typesMapListStream = TypesService.getAll(
      selectedTypeStake: selectedTypeStake, /* productId: productId*/
    );
    // final productsList =
    //    await ProductsController.getAll(selectedProductPrice: '*').first;
    // yield all types data or an empty list
    yield* typesMapListStream.map(
      (typesMapList) => typesMapList.map(
        (typeMap) {
          /*
          // will store types products ids
          List<int> typesProductsIds = [];
          // will store types products numbers
          List<int> typesProductsNumber = [];

          for (int i = 0; i < typeMap[TypeTable.products].length; i++) {
            typesProductsIds
                .add(typeMap[TypeTable.products][i][ProductTable.id].toInt());
            typesProductsNumber.add(
                typeMap[TypeTable.products][i][ProductTable.number].toInt());
          }

          List<Product> typeProducts = productsList.where(
            (product) {
              // check if products id is in types product ids
              if (typesProductsIds.contains(product.id)) {
                //  if true set the product number to it number containing by typesProductsNumber
                product.number =
                    typesProductsNumber[typesProductsIds.indexOf(product.id!)];
              }
              return typesProductsIds.contains(product.id);
            },
          ).toList();

          debugPrint('types Map: $typeMap');
          debugPrint('types products ids: ${typesProductsIds.toString()}');
          debugPrint(
              'types products numbers: ${typesProductsNumber.toString()}');
*/
          return Type(
            id: typeMap[TypeTable.id]?.toInt() ?? 0,
            name: typeMap[TypeTable.name],
            stake: typeMap[TypeTable.stake]?.toDouble() ?? .0,
            products: [] /*typeProducts.map((product) {
              int productNumberIndex = typesProductsIds.indexOf(product.id!);
              product.number = typesProductsNumber[productNumberIndex];
              return product;
            }).toList()*/
            ,
            createdAt: DateTime.parse(typeMap[TypeTable.createdAt]),
            updatedAt: DateTime.parse(typeMap[TypeTable.createdAt]),
          );
        },
      ).toList(),
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
