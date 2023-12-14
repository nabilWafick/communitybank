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

final customerNciNumberProvider = StateProvider<String>(
  (ref) {
    return '';
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
    return '';
  },
);

final customerPictureProvider = StateProvider<String?>(
  (ref) {
    return '';
  },
);
