import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/models/response/response.model.dart';

class TypesController {
  static Response create({required Type type}) {
    return Response.success;
  }

  static Type? getOne({required int id}) {
    return null;
  }

  static List<Type>? getAll() {
    return null;
  }

  static Response update({required int id, required Type type}) {
    return Response.success;
  }

  static Response delete({required int id}) {
    return Response.success;
  }
}
