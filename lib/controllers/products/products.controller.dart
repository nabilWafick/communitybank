import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
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

  static Stream<List<Product>> getAll() async* {
    final productMapListStream = ProductsService.getAll();

    // yield all products data or an empty list
    yield* productMapListStream.map((productMapList) => productMapList
        .map(
          (productMap) => Product.fromMap(productMap),
        )
        .toList());
    //.asBroadcastStream();
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

  static Future<ServiceResponse> delete({required int id}) async {
    final response = await ProductsService.delete(id: id);
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
