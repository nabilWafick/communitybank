import 'package:flutter_riverpod/flutter_riverpod.dart';

final customerNameProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final customerFirstnamesProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final customerPhoneNumberProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final customerAddressProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final customerProfessionProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final customerNicNumberProvider = StateProvider<int>(
  (ref) {
    return 0;
  },
);

final customerSignaturePictureProvider = StateProvider<String?>(
  (ref) {
    return;
  },
);

final customerProfilePictureProvider = StateProvider<String?>(
  (ref) {
    return;
  },
);

class CustomerValidators {
  static String? customerName(String? value, WidgetRef ref) {
    if (ref.watch(customerNameProvider).trim() == '') {
      return 'Entrez le nom du client';
    } else if (ref.watch(customerNameProvider).length < 3) {
      return "Le nom doit contenir au moins 3 lettres";
    }
    return null;
  }

  static String? customerFirstnames(String? value, WidgetRef ref) {
    if (ref.watch(customerFirstnamesProvider).trim() == '') {
      return 'Entrez le(s) prénom(s) nom du client';
    } else if (ref.watch(customerFirstnamesProvider).length < 3) {
      return "Le(s) prénom(s) doit contenir au moins 3 lettres";
    }
    return null;
  }

  static String? customerPhoneNumber(String? value, WidgetRef ref) {
    if (ref.watch(customerPhoneNumberProvider).trim() == '') {
      return 'Entrez un numéro de téléphone';
    } else if (!RegExp(r'^(\+229|00229)[4569]\d{7}$')
        .hasMatch(ref.watch(customerPhoneNumberProvider))) {
      return "Le numéro de téléphone est incorrect";
    }
    return null;
  }

  static String? customerAddress(String? value, WidgetRef ref) {
    if (ref.watch(customerAddressProvider).trim() == '') {
      return 'Entrez l\'adresse du client';
    } else if (ref.watch(customerAddressProvider).length < 5) {
      return "L'adresse doit contenir au moins 5 lettres";
    }
    return null;
  }

  static String? customerProfession(String? value, WidgetRef ref) {
    if (ref.watch(customerProfessionProvider) != '' &&
        ref.watch(customerProfessionProvider).length < 5) {
      return "La profession doit contenir au moins 5 lettres";
    }
    return null;
  }

  static String? customerNicNumber(String? value, WidgetRef ref) {
    if (ref.watch(customerNicNumberProvider) != 0 &&
        ref.watch(customerNicNumberProvider).toString().length < 10) {
      return 'Entrez un numéro NCI valide';
    }
    return null;
  }
}
