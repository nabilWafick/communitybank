import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/customer_daily_activity/customer_daily_activity.model.dart';
import 'package:communitybank/services/customer_daily_activity/customer_daily_activity.service.dart';

class CustomerDailyActivityController {
  static Future<List<CustomerDailyActivity>> getCustomerDailyActivity({
    required DateTime? collectionDate,
    required int? collectorId,
    required int? customerAccountId,
    required int? settlementsTotal,
  }) async {
    final customerDailyActivities =
        await CustomerDailyActivityService.getCustomerDailyActivity(
      collectionDate: collectionDate != null
          ? FunctionsController.getSQLFormatDate(collectionDate)
          : null,
      collectorId: collectorId,
      customerAccountId: customerAccountId,
      settlementsTotal: settlementsTotal,
    );

    return customerDailyActivities
        .map(
          (customerDailyActivity) => CustomerDailyActivity.fromMap(
            customerDailyActivity,
          ),
        )
        .toList();
  }
}
