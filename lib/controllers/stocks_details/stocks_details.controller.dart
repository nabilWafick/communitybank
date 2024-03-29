import 'package:communitybank/models/data/stock_detail/stock_detail.model.dart';
import 'package:communitybank/services/stocks_details/stocks_details.service.dart';

class StocksDetailsController {
  static Future<List<StockDetail>> getStocksDetails({
    required int? productId,
    required int? agentId,
    required int? customerCardId,
    required int? customerAccountId,
    required int? typeId,
    required String? stockType,
    required String? stockMovementDate,
  }) async {
    final stocksDetails = await StocksDetailsService.getStocksDetails(
      productId: productId,
      agentId: agentId,
      customerCardId: customerCardId,
      customerAccountId: customerAccountId,
      typeId: typeId,
      stockType: stockType,
      stockMovementDate: stockMovementDate,
    );

    return stocksDetails.map(
      (stockDetail) {
        return StockDetail.fromMap(
          stockDetail,
        );
      },
    ).toList();
  }
}
