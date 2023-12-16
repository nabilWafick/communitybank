import 'package:communitybank/models/data/customers_category/customers_category.model.dart';
import 'package:communitybank/models/response/response.model.dart';

class CustomerCategorysController {
  static Response create({required CustomerCategory customerCategory}) {
    return Response.success;
  }

  static CustomerCategory? getOne({required int id}) {
    return null;
  }

  static List<CustomerCategory>? getAll() {
    return null;
  }

  static Response update(
      {required int id, required CustomerCategory customerCategory}) {
    return Response.success;
  }

  static Response delete({required int id}) {
    return Response.success;
  }
}
