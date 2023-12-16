import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/models/response/response.model.dart';

class CustomersController {
  static Response create({required Customer customer}) {
    return Response.success;
  }

  static Customer? getOne({required int id}) {
    return null;
  }

  static List<Customer>? getAll() {
    return null;
  }

  static Response update({required int id, required Customer customer}) {
    return Response.success;
  }

  static Response delete({required int id}) {
    return Response.success;
  }
}
