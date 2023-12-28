// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/forms/validators/collector/collector.validator.dart';
import 'package:communitybank/controllers/collectors/collectors.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/utils/constants/constants.util.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectorCRUDFunctions {
  static Future<void> create({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final collectorPicture = ref.watch(collectorPictureProvider);
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final collectorName = ref.watch(collectorNameProvider);
      final collectorFirstnames = ref.watch(collectorFirstnamesProvider);
      final collectorPhoneNumber = ref.watch(collectorPhoneNumberProvider);
      final collectorAddress = ref.watch(collectorAddressProvider);

      ServiceResponse collectorStatus;

      if (collectorPicture == null) {
        final collector = Collector(
          name: collectorName,
          firstnames: collectorFirstnames,
          phoneNumber: collectorPhoneNumber,
          address: collectorAddress,
          profile: collectorPicture,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        collectorStatus =
            await CollectorsController.create(collector: collector);

        // debugPrint('new collector: $collectorStatus');
      } else {
        final collectorRemotePath = await collectorsController.uploadPicture(
          collectorPicturePath: collectorPicture,
        );

        if (collectorRemotePath != null) {
          final collector = Collector(
            name: collectorName,
            phoneNumber: collectorPhoneNumber,
            address: collectorAddress,
            profile: '${CBConstants.supabaseStorageLink}/$collectorRemotePath',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          collectorStatus =
              await collectorsController.create(collector: collector);

          //  debugPrint('new collector: $collectorStatus');
        } else {
          collectorStatus = ServiceResponse.failed;
        }
      }
      if (collectorStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: collectorStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: collectorStatus,
          response: 'Opération échouée',
        );
        showValidatedButton.value = true;
      }
      FunctionsController.showAlertDialog(
        context: context,
        alertDialog: const ResponseDialog(),
      );
    }
  }

  static Future<void> update({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required collector collector,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final collectorPicture = ref.watch(collectorPictureProvider);
    formKey.currentState!.save();
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final collectorName = ref.watch(collectorNameProvider);
      final collectorPhoneNumber = ref.watch(collectorPhophoneNumberProvider);

      ServiceResponse lastcollectorStatus;

      if (collectorPicture == null) {
        final newcollector = Collector(
          name: collectorName,
          phoneNumber: collectorPhoneNumber,
          address: collectorAddress,
          profile: collector.picture,
          createdAt: collector.createdAt,
          updatedAt: DateTime.now(),
        );

        lastcollectorStatus = await collectorsController.update(
          id: collector.id!,
          collector: newcollector,
        );

        // debugPrint('new collector: $collectorStatus');
      } else {
        String? collectorRemotePath;
        // if the collector haven't a picture before
        if (collector.picture == null) {
          collectorRemotePath = await collectorsController.uploadPicture(
              collectorPicturePath: collectorPicture);
        } else {
          collectorRemotePath =
              await collectorsController.updateUploadedPicture(
            collectorPictureLink: collector.picture!,
            newcollectorPicturePath: collectorPicture,
          );
        }

        final newcollector = Collector(
          name: collectorName,
          phoneNumber: collectorPhoneNumber,
          address: collectorAddress,
          profile: '${CBConstants.supabaseStorageLink}/$collectorRemotePath',
          createdAt: collector.createdAt,
          updatedAt: DateTime.now(),
        );

        lastcollectorStatus = await collectorsController.update(
          id: collector.id!,
          collector: newcollector,
        );

        //  debugPrint('new collector: $collectorStatus');
      }
      if (lastcollectorStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastcollectorStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastcollectorStatus,
          response: 'Opération échouée',
        );
        showValidatedButton.value = true;
      }
      FunctionsController.showAlertDialog(
        context: context,
        alertDialog: const ResponseDialog(),
      );
    }
  }

  static Future<void> delete({
    required BuildContext context,
    required WidgetRef ref,
    required int collectorId,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    showConfirmationButton.value = false;

    ServiceResponse collectorStatus;

    collectorStatus = await collectorsController.delete(id: collectorId);

    if (collectorStatus == ServiceResponse.success) {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: collectorStatus,
        response: 'Opération réussie',
      );
      Navigator.of(context).pop();
    } else {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: collectorStatus,
        response: 'Opération échouée',
      );
      showConfirmationButton.value = true;
    }
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const ResponseDialog(),
    );
    return;
  }
}
