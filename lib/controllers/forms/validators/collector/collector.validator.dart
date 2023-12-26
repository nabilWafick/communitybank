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

class CollectorValidors {
  static String? collectorName(String? value, WidgetRef ref) {
    if (ref.watch(collectorNameProvider) == '') {
      return 'Entrez le nom du collecteur';
    } else if (ref.watch(collectorNameProvider).length < 3) {
      return "Le nom doit contenir au moins 3 lettres";
    }
    return null;
  }

  static String? collectorFirstnames(String? value, WidgetRef ref) {
    if (ref.watch(collectorFirstnamesProvider) == '') {
      return 'Entrez le(s) prénom(s) du collecteur';
    } else if (ref.watch(collectorFirstnamesProvider).length < 3) {
      return "Le(s) prénom(s) doit contenir au moins 3 lettres";
    }
    return null;
  }

  static String? collectorPhoneNumber(String? value, WidgetRef ref) {
    if (ref.watch(collectorPhoneNumberProvider) == '') {
      return 'Entrez un numéro de téléphone';
    } else if (!RegExp(r'^(\+229|00229)[4569]\d{7}$')
        .hasMatch(ref.watch(collectorPhoneNumberProvider))) {
      return "Le numéro de téléphone est incorrect";
    }
    return null;
  }

  static String? collectorAddress(String? value, WidgetRef ref) {
    if (ref.watch(collectorAddressProvider) == '') {
      return 'Entrez l\'adresse du collecteur';
    } else if (ref.watch(collectorAddressProvider).length < 3) {
      return "L'adresse doit contenir au moins 3 lettres";
    }
    return null;
  }
}
