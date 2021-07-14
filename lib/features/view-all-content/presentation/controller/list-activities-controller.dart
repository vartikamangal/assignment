import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/page-request.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/usecases/list-activities.dart';

/// On each paginated request, the server will return a new page of activities
/// with extra [PageSize] number of activities.
const int PageSize = 5;

class ListActivitiesController extends GetxController {
  final ListAllActivities listAllActivities;

  ListActivitiesController({required this.listAllActivities});

  /// Fetches activities from the server.
  Future<List<Activity>> fetchActivities(int offset) async {
    final failureOrResult = await listAllActivities(
        ListAllActivitiesParams(PageRequest.fromOffset(PageSize, offset)));
    if (failureOrResult != null) {
      return failureOrResult.fold(
        (f) {
          //TODO add error state
          throw UnimplementedError();
        },
        (r) {
          // preloadedActivities.addAll(r.content);
          return r.content;
        },
      );
    } else {
      throw UnimplementedError();
    }
  }
}
