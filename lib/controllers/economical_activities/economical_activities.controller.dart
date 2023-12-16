import 'package:communitybank/models/data/economical_activity/economical_activity.model.dart';
import 'package:communitybank/models/response/response.model.dart';

class EconomicalActivitysController {
  static Response create({required EconomicalActivity economicalActivity}) {
    return Response.success;
  }

  static EconomicalActivity? getOne({required int id}) {
    return null;
  }

  static List<EconomicalActivity>? getAll() {
    return null;
  }

  static Response update(
      {required int id, required EconomicalActivity economicalActivity}) {
    return Response.success;
  }

  static Response delete({required int id}) {
    return Response.success;
  }
}
