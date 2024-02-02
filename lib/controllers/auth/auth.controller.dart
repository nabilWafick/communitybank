import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/services/auth/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController {
  static Future<ServiceResponse> signUp({
    required String email,
    required String password,
  }) async {
    final response = await AuthService.signUp(
      email: email,
      password: password,
    );

    return response.runtimeType != AuthResponse
        ? ServiceResponse.success
        : ServiceResponse.failed;
  }

  static Future<ServiceResponse> signIn({
    required String email,
    required String password,
  }) async {
    final response = await AuthService.signIn(
      email: email,
      password: password,
    );

    debugPrint('response runimeType:${response.runtimeType}');

    return response.runtimeType == AuthResponse
        ? ServiceResponse.success
        : ServiceResponse.failed;
  }

  static Future<ServiceResponse> signOut() async {
    final response = await AuthService.signOut();

    return response.runtimeType == Null
        ? ServiceResponse.success
        : ServiceResponse.failed;
  }

  static Future<dynamic> resetPasswordForEmail({required String email}) async {
    final response = await AuthService.resetPasswordForEmail(
      email: email,
    );

    return response.runtimeType == Null
        ? ServiceResponse.success
        : ServiceResponse.failed;
  }
}
