import 'package:communitybank/controllers/forms/on_changed/common/common.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/customer_category/customer_category.validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerCategoryOnChanged {
  static customerCategoryName(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        customerCategoryNameProvider,
      );
}
