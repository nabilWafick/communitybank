import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static Future<dynamic> signUp({
    required String email,
    required String password,
  }) async {
    dynamic response;
    final supabase = Supabase.instance.client;

    try {
      // try to create a new user
      response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      // return auth response
      return response;
    } catch (error) {
      debugPrint(error.toString());
      return error;
    }
    // return null;
  }

  static Future<dynamic> signIn({
    required String email,
    required String password,
  }) async {
    dynamic response;
    final supabase = Supabase.instance.client;

    try {
      // try to sign in an user
      response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      // return auth response
      return response;
    } catch (error) {
      debugPrint(error.toString());
      return error;
    }
    //  return null;
  }

  static Future<dynamic> signOut() async {
    final supabase = Supabase.instance.client;

    try {
      // try to logout
      await supabase.auth.signOut();
    } catch (error) {
      debugPrint(error.toString());
      return error;
    }
  }

  static Future<dynamic> resetPasswordForEmail({
    required String email,
  }) async {
    dynamic response;
    final supabase = Supabase.instance.client;

    try {
      // try to reset
      await supabase.auth.resetPasswordForEmail(
        email,
      );
      // return auth response
      return response;
    } catch (error) {
      debugPrint(error.toString());
      return error;
    }
  }
}
