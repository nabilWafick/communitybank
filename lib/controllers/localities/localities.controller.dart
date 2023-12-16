import 'package:communitybank/models/data/locality/locality.model.dart';
import 'package:communitybank/models/response/response.model.dart';

class LocalitysController {
  static Response create({required Locality locality}) {
    return Response.success;
  }

  static Locality? getOne({required int id}) {
    return null;
  }

  static List<Locality>? getAll() {
    return null;
  }

  static Response update({required int id, required Locality locality}) {
    return Response.success;
  }

  static Response delete({required int id}) {
    return Response.success;
  }
}
