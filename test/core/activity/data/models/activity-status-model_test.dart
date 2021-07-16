import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/features/view-all-content/data/models/data-model.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/entity.dart';

class ActivityStatus extends Entity {
  final int? id;
  final String? journeyId;
  final String? recommendationId;
  final String? actionStatus;
  final String? feedbackMood;
  final String? feedbackThoughts;
  ActivityStatus({
    required this.id,
    required this.journeyId,
    required this.recommendationId,
    required this.actionStatus,
    required this.feedbackMood,
    required this.feedbackThoughts,
  });
}

class ActivityStatusModel extends DataModel<ActivityStatus> {
  int? id;
  String? journeyId;
  String? recommendationId;
  String? actionStatus;
  String? feedbackMood;
  String? feedbackThoughts;

  ActivityStatusModel.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['actionId'] as int?,
        journeyId = jsonMap['journeyId'] as String?,
        recommendationId = jsonMap['recommendationId'] as String?,
        actionStatus = jsonMap['actionStatus'] as String?,
        feedbackMood = jsonMap['feedbackMood'] as String?,
        feedbackThoughts = jsonMap['feedbackThoughts'] as String?;

  ActivityStatusModel.fromDomain(ActivityStatus status)
      : id = status.id,
        journeyId = status.journeyId,
        recommendationId = status.recommendationId,
        actionStatus = status.actionStatus,
        feedbackMood = status.feedbackMood,
        feedbackThoughts = status.feedbackThoughts;

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "journeyId": journeyId,
      "recommendationId": recommendationId,
      "actionStatus": actionStatus,
      "feedbackMood": feedbackMood,
      "feedbackThoughts": feedbackThoughts,
    };
  }

  @override
  ActivityStatus toDomain() {
    return ActivityStatus(
      id: id,
      journeyId: journeyId,
      recommendationId: recommendationId,
      actionStatus: actionStatus,
      feedbackMood: feedbackMood,
      feedbackThoughts: feedbackThoughts,
    );
  }
}

void main() {
  final activityStatus = ActivityStatus(
      id: 1,
      journeyId: 'journeyId',
      recommendationId: 'recommendationId',
      actionStatus: 'actionStatus',
      feedbackMood: 'feedbackMood',
      feedbackThoughts: 'feedbackThoughts');
  test('pagination classes working', () async {
    // "e as TestEntity" shows code is susceptible to runtime typcasting errors
    final tTagModel = ActivityStatusModel.fromDomain(activityStatus);
    final p = tTagModel.toDomain();
    final j = tTagModel.toJson();
    final pm = ActivityStatusModel.fromJson(j);
  });
}
