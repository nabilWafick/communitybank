import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/customer_periodic_activity/customer_periodic_activity.model.dart';
import 'package:communitybank/services/customer_periodic_activity/customer_periodic_activity.service.dart';

class CustomerPeriodicActivityController {
  static Future<List<CustomerPeriodicActivity>> getCustomerPeriodicActivity({
    required DateTime? collectionBeginDate,
    required DateTime? collectionEndDate,
    required int? collectorId,
    required int? customerAccountId,
    required int? settlementsTotal,
  }) async {
    final customerPeriodicActivities =
        await CustomerPeriodicActivityService.getCustomerPeriodicActivity(
      collectionBeginDate: collectionBeginDate != null
          ? FunctionsController.getSQLFormatDate(collectionBeginDate)
          : null,
      collectionEndDate: collectionEndDate != null
          ? FunctionsController.getSQLFormatDate(collectionEndDate)
          : null,
      collectorId: collectorId,
      customerAccountId: customerAccountId,
      settlementsTotal: settlementsTotal,
    );

    return customerPeriodicActivities
        .map(
          (customerPeriodicActivity) => CustomerPeriodicActivity.fromMap(
            customerPeriodicActivity,
          ),
        )
        .toList();
  }
}
