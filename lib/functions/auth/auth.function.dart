// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/agent/agent.controller.dart';
import 'package:communitybank/controllers/forms/validators/registration/registration.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
            'Opération annulée \n Compte non créé \n Email Inconnu';
      } else {
        final supabase = Supabase.instance.client;

        final authResponse = await supabase.auth.signUp(
          email: newUserEmail,
          password: newUserPassword,
        );

        if (authResponse.user != null) {
          newUserStatus = ServiceResponse.success;
          authResponseMessage =
              'Opération réussie \n Compte créé avec succès !';
        } else {
          newUserStatus = ServiceResponse.failed;
          authResponseMessage = 'Opération échouée \n Compte non créé';
        }
      }

      if (newUserStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: newUserStatus,
          response: authResponseMessage,
        );
        showRegistrationButton.value = true;
        Navigator.of(context).pop();
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
}
