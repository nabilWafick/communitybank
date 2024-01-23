// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/agent/agent.controller.dart';
import 'package:communitybank/controllers/forms/validators/login/login.validator.dart';
import 'package:communitybank/controllers/forms/validators/registration/registration.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/main.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthFunctions {
  static Future<void> register({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showRegistrationButton,
  }) async {
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showRegistrationButton.value = false;
      final newUserEmail = ref.watch(newUserEmailProvider);
      final newUserPassword = ref.watch(newUserPasswordProvider);

      ServiceResponse newUserStatus;

      final agent = await AgentsController.getOneByEmail(email: newUserEmail);

      String authResponseMessage = '';

      if (agent == null) {
        newUserStatus = ServiceResponse.failed;
        authResponseMessage =
            'Opération annulée \nCompte non créé : Email Inconnu';
      } else {
        final supabase = Supabase.instance.client;

        final authResponse = await supabase.auth.signUp(
          email: newUserEmail,
          password: newUserPassword,
        );

        if (authResponse.user != null) {
          newUserStatus = ServiceResponse.success;
          authResponseMessage = 'Opération réussie \nCompte créé avec succès !';
        } else {
          newUserStatus = ServiceResponse.failed;
          authResponseMessage = 'Opération échouée \nCompte non créé';
        }
      }

      if (newUserStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: newUserStatus,
          response: authResponseMessage,
        );
        showRegistrationButton.value = true;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MainApp(),
          ),
        );
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: newUserStatus,
          response: authResponseMessage,
        );
        showRegistrationButton.value = true;
      }
      FunctionsController.showAlertDialog(
        context: context,
        alertDialog: const ResponseDialog(),
      );
    }
  }

  static Future<void> login({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showLoginButton,
  }) async {
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showLoginButton.value = false;
      final userEmail = ref.watch(userEmailProvider);
      final userPassword = ref.watch(userPasswordProvider);

      ServiceResponse userStatus;

      final agent = await AgentsController.getOneByEmail(email: userEmail);

      String authResponseMessage = '';

      if (agent == null) {
        userStatus = ServiceResponse.failed;
        authResponseMessage =
            'Opération annulée \nNon connecté : Email Inconnu';
      } else {
        final supabase = Supabase.instance.client;

        final authResponse = await supabase.auth.signInWithPassword(
          email: userEmail,
          password: userPassword,
        );

        if (authResponse.user != null) {
          userStatus = ServiceResponse.success;
          authResponseMessage = 'Opération réussie \nConnecté avec succès !';
        } else {
          userStatus = ServiceResponse.failed;
          authResponseMessage = 'Opération échouée \nNon connecté';
        }
      }

      if (userStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: userStatus,
          response: authResponseMessage,
        );
        showLoginButton.value = true;

        //  set user data in shared preferences
        final prefs = await SharedPreferences.getInstance();

        // set the agent id so as to facilitate some tasks like settlements adding
        prefs.setInt(CBConstants.agentIdPrefKey, agent!.id!);

        // set the agent name for main app bar view
        prefs.setString(CBConstants.agentNamePrefKey, agent.name);

        // set the agent firstnames for main app bar view
        prefs.setString(CBConstants.agentFirstnamesPrefKey, agent.firstnames);

        // set the agent email
        prefs.setString(CBConstants.agentEmailPrefKey, agent.email);

        //  Navigator.of(context).push(
        //    MaterialPageRoute(
        //      builder: (context) => const MainApp(),
        //    ),
        //  );
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: userStatus,
          response: authResponseMessage,
        );
        showLoginButton.value = true;
      }
      FunctionsController.showAlertDialog(
        context: context,
        alertDialog: const ResponseDialog(),
      );
    }
  }

  static Future<void> logout(BuildContext context) async {
    final supabase = Supabase.instance.client;

    await supabase.auth.signOut();

    //  set user data in shared preferences
    final prefs = await SharedPreferences.getInstance();

    // remove the agent id so as to facilitate some tasks like settlements adding
    prefs.remove(CBConstants.agentIdPrefKey);

    // remove the agent name for main app bar view
    prefs.remove(CBConstants.agentNamePrefKey);

    // remove the agent firstnames for main app bar view
    prefs.remove(CBConstants.agentFirstnamesPrefKey);

    // remove the agent email
    prefs.remove(CBConstants.agentEmailPrefKey);

    //  Navigator.of(context).push(
    //    MaterialPageRoute(
    //      builder: (context) => const MainApp(),
    //    ),
    //  );
  }
}
