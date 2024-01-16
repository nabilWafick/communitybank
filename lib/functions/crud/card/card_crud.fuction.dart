import 'package:communitybank/models/data/card/card.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/services/card/card.service.dart';

class CardsController {
  static Future<ServiceResponse> create({required Card card}) async {
    final response = await CardsService.create(card: card);
    // return response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<Card?> getOne({required int id}) async {
    final response = await CardsService.getOne(id: id);
    // return the specific Card data or null
    return response == null ? null : Card.fromMap(response);
  }

  static Stream<List<Card>> getAll() async* {
    final cardsMapListStream = CardsService.getAll();

    // yield all Cards data or an empty list
    yield* cardsMapListStream.map(
      (cardsMapList) => cardsMapList
          .map(
            (cardMap) => Card.fromMap(cardMap),
          )
          .toList(),
    );
    //.asBroadcastStream();
  }

  static Future<List<Card>> searchCard({required String name}) async {
    final searchedCards = await CardsService.searchCard(name: name);

    return searchedCards
        .map(
          (cardMap) => Card.fromMap(cardMap),
        )
        .toList();
  }

  static Future<ServiceResponse> update(
      {required int id, required Card card}) async {
    final response = await CardsService.update(
      id: id,
      card: card,
    );
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<ServiceResponse> delete({required Card card}) async {
    final response = await CardsService.delete(card: card);
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }
}
