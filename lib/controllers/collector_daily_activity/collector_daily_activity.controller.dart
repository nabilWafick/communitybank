import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/collector_daily_activity/collector_daily.model.dart';
import 'package:communitybank/services/collector_daily_activity/collector_daily_activity.service.dart';

class CollectorDailyActivityController {
  static Future<List<CollectorDailyActivity>> getCollectorDailyActivity({
    required DateTime? collectionDate,
    required int? collectorId,
  }) async {
    final collectorDailyActivities =
        await CollectorDailyActivityService.getCollectorDailyActivity(
      collectionDate: collectionDate != null
          ? FunctionsController.getSQLFormatDate(dateTime: collectionDate)
          : null,
      collectorId: collectorId,
    );

    return collectorDailyActivities
        .map(
          (collectorDailyActivity) => CollectorDailyActivity.fromMap(
            collectorDailyActivity,
          ),
        )
        .toList();
  }
}
