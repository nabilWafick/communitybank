import 'package:flutter_riverpod/flutter_riverpod.dart';

final customerCategoryNameProvider = StateProvider<String>((ref) {
  return '';
});

class CustomerCategoryValidators {
  static String? customerCategoryName(String? value, WidgetRef ref) {
    if (ref.watch(customerCategoryNameProvider).trim() == '') {
      return 'Entrez le nom d\'une catégorie';
    } else if (ref.watch(customerCategoryNameProvider).length < 3) {
      return "La catégorie doit contenir au moins 3 lettres";
    }
    return null;
  }
}
