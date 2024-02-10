import 'package:flutter_riverpod/flutter_riverpod.dart';

final collectorNameProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final collectorFirstnamesProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final collectorPhoneNumberProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final collectorAddressProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final collectorPictureProvider = StateProvider<String?>(
  (ref) {
    return;
  },
);

class CollectorValidators {
  static String? collectorName(String? value, WidgetRef ref) {
    if (ref.watch(collectorNameProvider).trim() == '') {
      return 'Entrez le nom du collecteur';
    } else if (ref.watch(collectorNameProvider).length < 3) {
      return "Le nom doit contenir au moins 3 lettres";
    }
    return null;
  }

  static String? collectorFirstnames(String? value, WidgetRef ref) {
    if (ref.watch(collectorFirstnamesProvider).trim() == '') {
      return 'Entrez le(s) prénom(s) du collecteur';
    } else if (ref.watch(collectorFirstnamesProvider).length < 3) {
      return "Le(s) prénom(s) doit contenir au moins 3 lettres";
    }
    return null;
  }

  static String? collectorPhoneNumber(String? value, WidgetRef ref) {
    if (ref.watch(collectorPhoneNumberProvider).trim() == '') {
      return 'Entrez le numéro de téléphone de l\'agent';
    } else if (!RegExp(r'^(\+229|00229)[4569]\d{7}$')
        .hasMatch(ref.watch(collectorPhoneNumberProvider))) {
      return "Le numéro de téléphone est incorrect";
    }
    return null;
  }

  static String? collectorAddress(String? value, WidgetRef ref) {
    if (ref.watch(collectorAddressProvider).trim() == '') {
      return 'Entrez l\'adresse du collecteur';
    } else if (ref.watch(collectorAddressProvider).length < 3) {
      return "L'adresse doit contenir au moins 3 lettres";
    }
    return null;
  }
}
