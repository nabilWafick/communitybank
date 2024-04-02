import 'package:communitybank/models/data/stock/stock.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/services/stocks/stocks.service.dart';

class StocksController {
  static Future<ServiceResponse> create({
    required Stock stock,
  }) async {
    final response = await StocksService.create(stock: stock);
    // return response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<Stock?> getOne({
    required int id,
  }) async {
    final response = await StocksService.getOne(id: id);
    // return the specific Stock data or null
    return response == null ? null : Stock.fromMap(response);
  }

  static Stream<List<Stock>> getAll({
    required int? selectedProductId,
  }) async* {
    final stocksMapListStream = StocksService.getAll(
      selectedProductId: selectedProductId,
    );

    Stream<List<Stock>> stocksListStream =
        // yield all Stocks data or an empty list
        stocksMapListStream.map(
      (stocksMapList) => stocksMapList.map(
        (stockMap) {
          return Stock.fromMap(stockMap);
        },
      ).toList(),
    );

    //.asBroadcastStream();

    yield* stocksListStream;
  }

  static Stream<List<Stock>> getAllConstrainedOutputStock({
    required int? selectedProductId,
    required String? selectedType,
    required DateTime? outputedAt,
  }) async* {
    final stocksMapListStream = StocksService.getAllConstrainedOutputStock(
      selectedProductId: selectedProductId,
      selectedType: selectedType,
    );

    Stream<List<Stock>> stocksListStream =
        // yield all Stocks data or an empty list
        stocksMapListStream.map(
      (stocksMapList) => stocksMapList.map(
        (stockMap) {
          return Stock.fromMap(stockMap);
        },
      ).toList(),
    );

    if (outputedAt != null) {
      stocksListStream = stocksListStream.map(
        (stockList) => stockList
            .where(
              (stock) =>
                  stock.createdAt.year == outputedAt.year &&
                  stock.createdAt.month == outputedAt.month &&
                  stock.createdAt.day == outputedAt.day,
            )
            .toList(),
      );
    }

    //.asBroadcastStream();

    yield* stocksListStream;
  }

  static Future<ServiceResponse> update({
    required int id,
    required Stock stock,
  }) async {
    final response = await StocksService.update(id: id, stock: stock);
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<ServiceResponse> delete({
    required Stock stock,
  }) async {
    final response = await StocksService.delete(stock: stock);
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }
}
