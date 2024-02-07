import 'package:communitybank/controllers/forms/on_changed/common/common.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/collection/collection.validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectionOnChanged {
  static collectionAmount(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onDoubleTextInputValueChanged(
        value,
        ref,
        collectionAmountProvider,
      );
}
