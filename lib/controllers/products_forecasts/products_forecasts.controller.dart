import 'package:communitybank/models/data/product_forecast/product_forecast.model.dart';
import 'package:communitybank/services/products_forecasts/products_forecasts.service.dart';

class ProductsForecastsController {
  static Future<List<ProductForecast>> getProductsForecasts({
    required int? productId,
    required int? settlementsTotal,
    required int? collectorId,
    required int? customerAccountId,
  }) async {
    final productsForecasts =
        await ProductsForecastsService.getProductsForecasts(
      productId: productId,
      settlementsTotal: settlementsTotal,
      customerAccountId: customerAccountId,
      collectorId: collectorId,
    );

    return productsForecasts.map(
      (productForecastMap) {
        //  debugPrint('productForecastMap: $productForecastMap');
        return ProductForecast.fromMap(
          productForecastMap,
        );
      },
    ).toList();
  }
}
