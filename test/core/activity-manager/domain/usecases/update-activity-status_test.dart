import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/activity-status.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/repositories/update-activity-status-service.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/usecases/update-activity-status.dart';

import 'update-activity-status_test.mocks.dart';

@GenerateMocks([UpdateActivityStatusService])
void main() {
  MockUpdateActivityStatusService? service;
  late UpdateActivityStatus useCase;

  setUp(() {
    service = MockUpdateActivityStatusService();
    useCase = UpdateActivityStatus(service: service);
  });

  const tStatus = "COMPLETED";
  const tAActionId = 19351;
  const tActivityStatus = ActivityStatus(
      id: 19351,
      journeyId: "1b942ecc-7c76-4237-8f8b-216b9c22e900",
      recommendationId: null,
      actionStatus: "COMPLETED",
      feedbackMood: "NEUTRAL",
      feedbackThoughts: "");

  group('USECASE : setTarget', () {
    test('should update the activityStatus with the help of service', () async {
      //arrange
      when(service!.updateStatus(
        status: tStatus,
        actionId: tAActionId,
      )).thenAnswer((_) async => const Right(tActivityStatus));
      //act
      final result = await useCase(const UpdateActivityStatusParams(
        status: tStatus,
        actionId: tAActionId,
      ));
      //assert
      verify(service!.updateStatus(
        status: tStatus,
        actionId: tAActionId,
      ));
      expect(result, const Right(tActivityStatus));
    });
  });
}
