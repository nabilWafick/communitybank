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
    return '';
  },
);
