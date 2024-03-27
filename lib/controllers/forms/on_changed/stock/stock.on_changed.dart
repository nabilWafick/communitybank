import 'package:communitybank/controllers/forms/on_changed/common/common.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/stock/stock.validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StockOnChanged {
  static stockManualInputedQuantity(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onIntTextInputValueChanged(
        value,
        ref,
        stockInputedQuantityProvider,
      );

  static stockManualOutputedQuantity(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onIntTextInputValueChanged(
        value,
        ref,
        stockOutputedQuantityProvider,
      );

  static stockConstrainedOuputProductNumber(
          String? value, int productIndex, WidgetRef ref) =>
      CommonOnChangedFunction.onIntTextInputValueChanged(
        value,
        ref,
        stockConstrainedOuputProductNumberProvider(productIndex),
      );
}
