import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/models/response/response.model.dart';

class ProductsController {
  static Response create({required Product product}) {
    return Response.success;
  }

  static Product? getOne({required int id}) {
    return null;
  }

  static List<Product>? getAll() {
    return null;
  }

  static Response update({required int id, required Product product}) {
    return Response.success;
  }

  static Response delete({required int id}) {
    return Response.success;
  }
}
