import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/collector_periodic_activity/collector_periodic_activity.model.dart';
import 'package:communitybank/services/collector_periodic_activity/collector_periodic_activity.service.dart';

class CollectorPeriodicActivityController {
  static Future<List<CollectorPeriodicActivity>> getCollectorPeriodicActivity({
    required DateTime? collectionBeginDate,
    required DateTime? collectionEndDate,
    required int? collectorId,
  }) async {
    final collectorPeriodicActivities =
        await CollectorPeriodicActivityService.getCollectorPeriodicActivity(
      collectionBeginDate: collectionBeginDate != null
          ? FunctionsController.getSQLFormatDate(collectionBeginDate)
          : null,
      collectionEndDate: collectionEndDate != null
          ? FunctionsController.getSQLFormatDate(collectionEndDate)
          : null,
      collectorId: collectorId,
    );

    return collectorPeriodicActivities
        .map(
          (collectorPeriodicActivity) => CollectorPeriodicActivity.fromMap(
            collectorPeriodicActivity,
          ),
        )
        .toList();
  }
}
