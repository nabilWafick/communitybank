import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResponseDialogModel {
  final ServiceResponse serviceResponse;
  final String response;
  ResponseDialogModel({
    required this.serviceResponse,
    required this.response,
  });

  ResponseDialogModel copyWith({
    ServiceResponse? serviceResponse,
    String? response,
  }) {
    return ResponseDialogModel(
      serviceResponse: serviceResponse ?? this.serviceResponse,
      response: response ?? this.response,
    );
  }
}

final responseDialogProvider = StateProvider<ResponseDialogModel>((ref) {
  return ResponseDialogModel(
      serviceResponse: ServiceResponse.waiting, response: 'Info');
});
