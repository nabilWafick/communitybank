import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/models/tables/customer_card/customer_card_table.model.dart';
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
      (customerCardsMapList) => customerCardsMapList.map(
        (customerCardMap) {
          return CustomerCard.fromMap(customerCardMap);
        },
      ).toList(),
    );
    //.asBroadcastStream();
  }

  static Stream<List<CustomerCard>> getAllWithOwner() async* {
    Stream<List<Map<String, dynamic>>> customerCardsMapListStream =
        CustomerCardsService.getAll();

    // filter and return only customer card which have an an owner i.e
    // only which are used by an account owner
    customerCardsMapListStream = customerCardsMapListStream.map(
      (customerCardsMapList) => customerCardsMapList
          .where((customerCardMap) =>
              customerCardMap[CustomerCardTable.customerAccountId] != null)
          .toList(),
    );

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

  static Stream<List<CustomerCard>> getAllWithoutOwner() async* {
    Stream<List<Map<String, dynamic>>> customerCardsMapListStream =
        CustomerCardsService.getAll();

// filter and return only customer card which have an an owner i.e only which are used by an account owner
    customerCardsMapListStream = customerCardsMapListStream.map(
      (customerCardsMapList) => customerCardsMapList
          .where((customerCardMap) =>
              customerCardMap[CustomerCardTable.customerAccountId] == null)
          .toList(),
    );

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
