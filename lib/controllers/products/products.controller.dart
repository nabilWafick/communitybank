import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/services/products/products.service.dart';

class ProductsController {
  static Future<Product> create({required Product product}) async {
    final response = await ProductsService.create(product: product);
    // return the inserted product
    return Product.fromMap(response);
  }

  static Future<Product?> getOne({required int id}) async {
    final response = await ProductsService.getOne(id: id);
    // return the specific product data
    return response == null ? null : Product.fromMap(response);
  }

  static Future<List<Product>> getAll() async {
    final response = await ProductsService.getAll();
    // return all products data
    return response
        .map(
          (productMap) => Product.fromMap(productMap),
        )
        .toList();
  }

  static Future<Product> update(
      {required int id, required Product product}) async {
    final response = await ProductsService.update(id: id, product: product);
    // return the updated product
    return Product.fromMap(response);
  }

  static Future<Product> delete({required int id}) async {
    final response = await ProductsService.delete(id: id);
    // return the updated product
    return Product.fromMap(response);
  }
}
