import 'package:communitybank/models/data/personal_status/personal_status.model.dart';
import 'package:communitybank/models/response/response.model.dart';

class PersonalStatussController {
  static Response create({required PersonalStatus personalStatus}) {
    return Response.success;
  }

  static PersonalStatus? getOne({required int id}) {
    return null;
  }

  static List<PersonalStatus>? getAll() {
    return null;
  }

  static Response update(
      {required int id, required PersonalStatus personalStatus}) {
    return Response.success;
  }

  static Response delete({required int id}) {
    return Response.success;
  }
}
