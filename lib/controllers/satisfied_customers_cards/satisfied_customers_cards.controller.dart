import 'package:communitybank/models/data/satisfied_customers_cards/satisfied_customers_cards.model.dart';
import 'package:communitybank/services/satisfied_customers_cards/satisfied_customers_cards.service.dart';

class SatisfiedCustomersCardsController {
  static Future<List<SatisfiedCustomersCards>> getSatisfiedCustomersCards({
    required String? beginDate,
    required String? endDate,
    required int? collectorId,
    required int? customerAccountId,
    required int? customerCardId,
    required int? typeId,
  }) async {
    final satisfiedCustomersCards =
        await SatisfiedCustomersCardsService.getSatisfiedCustomersCards(
      beginDate: beginDate,
      endDate: endDate,
      collectorId: collectorId,
      customerAccountId: customerAccountId,
      customerCardId: customerCardId,
      typeId: typeId,
    );

    return satisfiedCustomersCards.map(
      (satisfiedCustomersCards) {
        return SatisfiedCustomersCards.fromMap(
          satisfiedCustomersCards,
        );
      },
    ).toList();
  }
}
