import 'package:communitybank/models/data/customers_category/customers_category.model.dart';
import 'package:communitybank/models/data/economical_activity/economical_activity.model.dart';
import 'package:communitybank/models/data/locality/locality.model.dart';
import 'package:communitybank/models/data/personal_status/personal_status.model.dart';
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

final customerNciNumberProvider = StateProvider<int>(
  (ref) {
    return 0;
  },
);

final customerCategorieProvider = StateProvider<CustomerCategory?>(
  (ref) {
    return;
  },
);

final customerEconomicalActivityProvider = StateProvider<EconomicalActivity?>(
  (ref) {
    return;
  },
);

final customerPersonalStatusProvider = StateProvider<PersonalStatus?>(
  (ref) {
    return;
  },
);

final customerLocalityProvider = StateProvider<Locality?>(
  (ref) {
    return;
  },
);

final customerSignatureProvider = StateProvider<String?>(
  (ref) {
    return;
  },
);

final customerPictureProvider = StateProvider<String?>(
  (ref) {
    return;
  },
);

class CustomerValidators {
  static String? customerName(String? value, WidgetRef ref) {
    if (ref.watch(customerNameProvider) == '') {
      return 'Entrez le nom du client';
    } else if (ref.watch(customerNameProvider).length < 3) {
      return "Le nom doit contenir au moins 3 lettres";
    }
    return null;
  }

  static String? customerFirstnames(String? value, WidgetRef ref) {
    if (ref.watch(customerFirstnamesProvider) == '') {
      return 'Entrez le(s) prénom(s) nom du client';
    } else if (ref.watch(customerFirstnamesProvider).length < 3) {
      return "Le(s) prénom(s) doit contenir au moins 3 lettres";
    }
    return null;
  }

  static String? customerPhoneNumber(String? value, WidgetRef ref) {
    if (ref.watch(customerPhoneNumberProvider) == '') {
      return 'Entrez un numéro de téléphone';
    } else if (!RegExp(r'^(\+229|00229)[4569]\d{7}$')
        .hasMatch(ref.watch(customerPhoneNumberProvider))) {
      return "Le numéro de téléphone est incorrect";
    }
    return null;
  }

  static String? customerAddress(String? value, WidgetRef ref) {
    if (ref.watch(customerAddressProvider) == '') {
      return 'Entrez l\'adresse du client';
    } else if (ref.watch(customerAddressProvider).length < 3) {
      return "L'adresse doit contenir au moins 3 lettres";
    }
    return null;
  }

  static String? customerProfession(String? value, WidgetRef ref) {
    if (ref.watch(customerProfessionProvider) == '') {
      return 'Entrez la profession du client';
    } else if (ref.watch(customerProfessionProvider).length < 3) {
      return "La profession doit contenir au moins 3 lettres";
    }
    return null;
  }

  static String? customerNciNumber(String? value, WidgetRef ref) {
    if (ref.watch(customerNciNumberProvider) == 0) {
      return 'Entrez le numéro de la CNI du client';
    } else if (ref.watch(customerNciNumberProvider).toString().length < 10) {
      return 'Entrez un numéro NCI valide';
    }
    return null;
  }
}
