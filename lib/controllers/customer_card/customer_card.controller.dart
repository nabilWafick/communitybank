import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/services/customer_card/customer_card.service.dart';

class CustomersCardsController {
  static Future<ServiceResponse> create(
      {required CustomerCard customerCard}) async {
    final response =
        await CustomerCardsService.create(customerCard: customerCard);
    // return response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<CustomerCard?> getOne({required int id}) async {
    final response = await CustomerCardsService.getOne(id: id);
    // return the specific CustomerCard data or null
    return response == null ? null : CustomerCard.fromMap(response);
  }

  static Stream<List<CustomerCard>> getAll() async* {
    final customerCardsMapListStream = CustomerCardsService.getAll();

    // yield all CustomerCards data or an empty list
    yield* customerCardsMapListStream.map(
      (customerCardsMapList) => customerCardsMapList
          .map(
            (customerCardMap) => CustomerCard.fromMap(customerCardMap),
          )
          .toList(),
    );
    //.asBroadcastStream();
  }

  static Future<List<CustomerCard>> searchCustomerCard(
      {required String label}) async {
    final searchedCustomerCards =
        await CustomerCardsService.searchCustomerCard(label: label);

    return searchedCustomerCards
        .map(
          (customerCardMap) => CustomerCard.fromMap(customerCardMap),
        )
        .toList();
  }

  static Future<ServiceResponse> update(
      {required int id, required CustomerCard customerCard}) async {
    final response = await CustomerCardsService.update(
      id: id,
      customerCard: customerCard,
    );
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<ServiceResponse> delete(
      {required CustomerCard customerCard}) async {
    final response =
        await CustomerCardsService.delete(customerCard: customerCard);
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }
}
