import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/models/tables/product/product_table.model.dart';
import 'package:communitybank/services/products/products.service.dart';

class ProductsController {
  static Future<ServiceResponse> create({required Product product}) async {
    final response = await ProductsService.create(product: product);
    // return response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<Product?> getOne({required int id}) async {
    final response = await ProductsService.getOne(id: id);
    // return the specific product data or null
    return response == null ? null : Product.fromMap(response);
  }

  static Stream<List<Product>> getAll(
      {required String selectedProductPrice}) async* {
    final productMapListStream =
        ProductsService.getAll(selectedProductPrice: selectedProductPrice);

    // yield all products data or an empty list
    yield* productMapListStream.map(
      (productMapList) => productMapList
          .map(
            (productMap) => Product.fromMap(productMap),
          )
          .toList(),
    );
    //.asBroadcastStream();
  }

  static Future<List<Product>> searchProduct({required String name}) async {
    final searchedProducts = await ProductsService.searchProduct(name: name);

    return searchedProducts
        .map(
          (productMap) => Product.fromMap(productMap),
        )
        .toList();
  }

  static Stream<List<double>> getAllProductsPurchasePrices() async* {
    final productsPurchasePricesStream =
        ProductsService.getAllProductsPurchasePrices();

    yield* productsPurchasePricesStream.map(
      (productsPurchasePrices) => productsPurchasePrices
          .map((productPurchase) =>
              productPurchase[ProductTable.purchasePrice] as double)
          .toList(),
    );
  }

  static Future<ServiceResponse> update(
      {required int id, required Product product}) async {
    final response = await ProductsService.update(
      id: id,
      product: product,
    );
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<ServiceResponse> delete({required Product product}) async {
    final response = await ProductsService.delete(product: product);
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<String?> uploadPicture(
      {required String productPicturePath}) async {
    final response = await ProductsService.uploadPicture(
        productPicturePath: productPicturePath);
    // return the remote path or null
    return response;
  }

  static Future<String?> updateUploadedPicture({
    required String productPictureLink,
    required String newProductPicturePath,
  }) async {
    final response = await ProductsService.updateUploadedPicture(
      productPictureLink: productPictureLink,
      newProductPicturePath: newProductPicturePath,
    );
    // return the remote path or null
    return response;
  }
}
