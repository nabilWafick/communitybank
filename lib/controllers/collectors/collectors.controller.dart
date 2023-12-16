import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/response/response.model.dart';

class CollectorsController {
  static Response create({required Collector collector}) {
    return Response.success;
  }

  static Collector? getOne({required int id}) {
    return null;
  }

  static List<Collector>? getAll() {
    return null;
  }

  static Response update({required int id, required Collector collector}) {
    return Response.success;
  }

  static Response delete({required int id}) {
    return Response.success;
  }
}
