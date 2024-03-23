// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/agents/agents.controller.dart';
import 'package:communitybank/controllers/auth/auth.controller.dart';
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
            'Opération annulée \nCompte non créé: Email Inconnu';
      } else {
        final registeringStatus = await AuthController.signUp(
          email: newUserEmail,
          password: newUserPassword,
        );

        if (registeringStatus == ServiceResponse.success) {
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

      ServiceResponse userStatus = ServiceResponse.waiting;

      final agent = await AgentsController.getOneByEmail(email: userEmail);

      String authResponseMessage = '';

      if (agent == null) {
        userStatus = ServiceResponse.failed;
        authResponseMessage =
            'Opération annulée \nNon connecté(e): Email Inconnu';
      } else {
        final loginStatus = await AuthController.signIn(
          email: userEmail,
          password: userPassword,
        );

        debugPrint('loginStatus: $loginStatus');

        if (loginStatus == ServiceResponse.success) {
          userStatus = ServiceResponse.success;
          authResponseMessage = 'Opération réussie \nConnecté(e) avec succès !';
        } else {
          userStatus = ServiceResponse.failed;
          authResponseMessage =
              'Opération échouée \nNon connecté(e): Identifiants incorrects';
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

        // set the agent role
        prefs.setString(CBConstants.agentRolePrefKey, agent.role);

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

  static Future<void> logout() async {
    await AuthController.signOut();

    final prefs = await SharedPreferences.getInstance();

    // remove the agent id
    prefs.remove(CBConstants.agentIdPrefKey);

    // remove the agent name
    prefs.remove(CBConstants.agentNamePrefKey);

    // remove the agent firstnames
    prefs.remove(CBConstants.agentFirstnamesPrefKey);
  }
}
