import 'package:communitybank/controllers/products/products.controller.dart';
import 'package:communitybank/models/data/product/product.model.dart';
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
    required String selectedTypeStake,
    required int? selectedProductId,
  }) async* {
    //  debugPrint('In Controller');
    Stream<List<Map<String, dynamic>>> typesMapListStream = TypesService.getAll(
      selectedTypeStake:
          selectedTypeStake, /* selectedProductId: selectedProductId*/
    );

// filter the stream when selectedProductId is null in order to get only types containing selectedProductId in productsIds
    if (selectedProductId != null) {
      typesMapListStream = typesMapListStream.map(
        (typesMapList) => typesMapList
            .where(
              (typeMap) =>
                  typeMap[TypeTable.productsIds].contains(selectedProductId),
            )
            .toList(),
      );
    }

    final productsListStream =
        ProductsController.getAll(selectedProductPrice: '*');

    await for (List<Product> productsList in productsListStream) {
      // debugPrint('In Stream');
      // debugPrint(productsList.toString());

      List<Product> typeProducts = [];

      yield* typesMapListStream.map(
        (typesMapList) => typesMapList.map(
          (typeMap) {
            typeProducts = [];

            for (Product product in productsList) {
              if (typeMap[TypeTable.productsIds].contains(product.id)) {
                //  debugPrint('Found');
                product.number = typeMap[TypeTable.productsNumbers]
                    .toList()[typeMap[TypeTable.productsIds]
                        .toList()
                        .indexOf(product.id!)]
                    .toInt();
                typeProducts.add(product);
              }
            }

            return Type(
              id: typeMap[TypeTable.id]?.toInt() ?? 0,
              name: typeMap[TypeTable.name],
              stake: typeMap[TypeTable.stake]?.toDouble() ?? .0,
              products: typeProducts,
              createdAt: DateTime.parse(typeMap[TypeTable.createdAt]),
              updatedAt: DateTime.parse(typeMap[TypeTable.createdAt]),
            );
          },
        ).toList(),
      );
    }

    /*  productsListStream.listen((productsListS) {
      productsList = productsListS;
      debugPrint('In Stream');
      debugPrint(productsList.toString());
    });

    debugPrint('Out Stream');
    debugPrint(productsList.toString());

    List<Product> typeProducts = [];

    // yield all types data or an empty list
    yield* typesMapListStream.map(
      (typesMapList) => typesMapList.map(
        (typeMap) {
          typeProducts = [];
          // map the products list stream form getting products data in real time
          productsList.map(
            // access to product
            (product) {
              debugPrint(typeMap[TypeTable.productsIds].toString());
              // check if product's id is in types products ids
              if (typeMap[TypeTable.productsIds]
                  //.toList()
                  .contains(product.id)) {
                debugPrint('Found');
                //  if true set the product number to it number containing by types products numbers
                product.number = typeMap[TypeTable.productsNumbers]
                    .toList()[
                        // since the product number is unknowed
                        // get the index by getting the the product's id index in type products ids
                        typeMap[TypeTable.productsIds]
                            .toList()
                            .indexOf(product.id!)]
                    .toInt();

                // add the product to typeProducts
                typeProducts.add(product);
              }
            },
          ).toList();

          // );

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
            products:
                typeProducts /*typeProducts.map((product) {
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
  */
  }

  static Future<List<Type>> searchType({required String name}) async {
    List<Map<String, dynamic>> searchedTypesMap =
        await TypesService.searchType(name: name);

    final productsList =
        await ProductsController.getAll(selectedProductPrice: '*').first;

    List<Type> searchedTypes = [];

    // debugPrint('In Stream');
    // debugPrint(productsList.toString());

    List<Product> typeProducts = [];

    searchedTypes = searchedTypesMap.map(
      (typeMap) {
        typeProducts = [];

        for (Product product in productsList) {
          if (typeMap[TypeTable.productsIds].contains(product.id)) {
            //  debugPrint('Found');
            product.number = typeMap[TypeTable.productsNumbers]
                .toList()[typeMap[TypeTable.productsIds]
                    .toList()
                    .indexOf(product.id!)]
                .toInt();
            typeProducts.add(product);
          }
        }

        return Type(
          id: typeMap[TypeTable.id]?.toInt() ?? 0,
          name: typeMap[TypeTable.name],
          stake: typeMap[TypeTable.stake]?.toDouble() ?? .0,
          products: typeProducts,
          createdAt: DateTime.parse(typeMap[TypeTable.createdAt]),
          updatedAt: DateTime.parse(typeMap[TypeTable.createdAt]),
        );
      },
    ).toList();
    // debugPrint('In Controller');
    // debugPrint('searchedTypes: $searchedTypes');
    return searchedTypes;
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
