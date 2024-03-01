import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/collector_periodic_activity/collector_periodic_activity.model.dart';
import 'package:communitybank/services/collector_periodic_activity/collector_periodic_activity.service.dart';

class CollectorPeriodicActivityController {
  static Future<List<CollectorPeriodicActivity>> getCollectorPeriodicActivity({
    required DateTime? collectionBeginDate,
    required DateTime? collectionEndDate,
    required int? collectorId,
    required int? customerAccountId,
    required int? settlementsTotal,
  }) async {
    final collectorPeriodicActivities =
        await CollectorPeriodicActivityService.getCollectorPeriodicActivity(
      collectionBeginDate: collectionBeginDate != null
          ? FunctionsController.getSQLFormatDate(dateTime: collectionBeginDate)
          : null,
      collectionEndDate: collectionEndDate != null
          ? FunctionsController.getSQLFormatDate(dateTime: collectionEndDate)
          : null,
      collectorId: collectorId,
      customerAccountId: customerAccountId,
      settlementsTotal: settlementsTotal,
    );
    //  debugPrint('customerAccountId: $customerAccountId');

    return collectorPeriodicActivities.map(
      (collectorPeriodicActivity) {
        // debugPrint('collectorPeriodicActivity: $collectorPeriodicActivity');
        return CollectorPeriodicActivity.fromMap(
          collectorPeriodicActivity,
        );
      },
    ).toList();
  }
}
