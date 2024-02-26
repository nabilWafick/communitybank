// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/collection/collection.controller.dart';
import 'package:communitybank/controllers/forms/validators/collection/collection.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/collection/collection.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/utils/constants/constants.util.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CollectionCRUDFunctions {
  static Future<void> create({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final collectionAmount = ref.watch(collectionAmountProvider);
      final collector = ref
          .watch(formCollectorDropdownProvider('collection-adding-collector'));
      final collectionDate = ref.watch(collectionDateProvider);

      // if collection date have not been selected
      if (collectionDate == null) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: ServiceResponse.failed,
          response: 'La date de collecte n\'a  pas été selectionnée',
        );
        showValidatedButton.value = true;
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const ResponseDialog(),
        );
      } else {
        final collectorCollections = await CollectionsController.getAll(
          collectorId: collector.id,
          collectedAt: collectionDate,
          agentId: 0,
        ).first;
        debugPrint('collector: $collector');
        debugPrint('collection date: $collectionDate');
        debugPrint('existing collection: $collectorCollections');

        //  check if the collector daily collection have been added

        if (collectorCollections.isNotEmpty) {
          ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
            serviceResponse: ServiceResponse.failed,
            response:
                'La somme collectée par le collecteur à cette date a été déjà enregistrée',
          );
          showValidatedButton.value = true;
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
        } else {
          ServiceResponse collectionStatus;

          final prefs = await SharedPreferences.getInstance();
          final agentId = prefs.getInt(CBConstants.agentIdPrefKey);

          final collection = Collection(
            collectorId: collector.id!,
            amount: collectionAmount,
            rest: collectionAmount,
            agentId: agentId ?? 0,
            collectedAt: collectionDate,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          collectionStatus = await CollectionsController.create(
            collection: collection,
          );

          if (collectionStatus == ServiceResponse.success) {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: collectionStatus,
              response: 'Opération réussie',
            );
            showValidatedButton.value = true;
            Navigator.of(context).pop();
          } else {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: collectionStatus,
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
    }
  }

  static Future<void> update({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required Collection collection,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState!.save();
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final collectionAmount = ref.watch(collectionAmountProvider);
      final collector = ref
          .watch(formCollectorDropdownProvider('collection-update-collector'));
      final collectionDate = ref.watch(collectionDateProvider);

      // if collection date have not been selected
      if (collectionDate == null) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: ServiceResponse.failed,
          response: 'La date de collecte n\'a  pas été selectionnée',
        );
        showValidatedButton.value = true;
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const ResponseDialog(),
        );
      } else {
        final collectorCollections = await CollectionsController.getAll(
          collectorId: collector.id,
          collectedAt: collectionDate,
          agentId: 0,
        ).first;

        //  check if the collector dayly collection have been added

        if (collectorCollections.isNotEmpty) {
          ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
            serviceResponse: ServiceResponse.failed,
            response:
                'La somme collectée par le collecteur à cette date a été déjà enregistrée',
          );
          showValidatedButton.value = true;
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
        } else {
          ServiceResponse lastCollectionStatus;

          final newCollection = Collection(
            collectorId: collector.id!,
            amount: collectionAmount,
            rest: collectionAmount,
            agentId: collection.agentId,
            collectedAt: collectionDate,
            createdAt: collection.createdAt,
            updatedAt: DateTime.now(),
          );

          lastCollectionStatus = await CollectionsController.update(
            id: collection.id!,
            collection: newCollection,
          );

          if (lastCollectionStatus == ServiceResponse.success) {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: lastCollectionStatus,
              response: 'Opération réussie',
            );
            showValidatedButton.value = true;
            Navigator.of(context).pop();
          } else {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: lastCollectionStatus,
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
    }
  }

  static Future<void> updateCollectionAmount({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required Collection collection,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    // formKey.currentState!.save();
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final collectionAmount = ref.watch(collectionAmountProvider);

      final collectorsCollections = await CollectionsController.getAll(
        collectorId: collection.collectorId,
        collectedAt: collection.collectedAt,
        agentId: collection.agentId,
      ).first;

      final collectorCollection = collectorsCollections.first;

      ServiceResponse lastCollectionStatus;

      final newCollection = Collection(
        collectorId: collection.collectorId,
        amount: collectorCollection.amount + collectionAmount,
        rest: collectorCollection.rest + collectionAmount,
        agentId: collection.agentId,
        collectedAt: collection.collectedAt,
        createdAt: collection.createdAt,
        updatedAt: DateTime.now(),
      );
      debugPrint('newCollection: $newCollection');

      lastCollectionStatus = await CollectionsController.update(
        id: collection.id!,
        collection: newCollection,
      );

      if (lastCollectionStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastCollectionStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastCollectionStatus,
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
    required Collection collection,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    showConfirmationButton.value = false;

    ServiceResponse collectionStatus;

    collectionStatus =
        await CollectionsController.delete(collection: collection);

    if (collectionStatus == ServiceResponse.success) {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: collectionStatus,
        response: 'Opération réussie',
      );
      Navigator.of(context).pop();
    } else {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: collectionStatus,
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
