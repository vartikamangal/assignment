import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/save-feedback-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/save-feedback.dart';

import 'save-feedback_test.mocks.dart';

@GenerateMocks([SaveFeedbackService])
void main() {
  late MockSaveFeedbackService service;
  late SaveFeedback useCase;

  setUp(() {
    service = MockSaveFeedbackService();
    useCase = SaveFeedback(service: service);
  });

  const tUnit = unit;

  const tSaveFeedback = SaveFeedbackParams(
      subjetcId: '',
      activityType: '',
      textFeedback: '',
      voiceNote: '',
      timeOfCreation: '',
      boxKey: '');
  group('USECASE: service.saveFeedback()', () {
    test('should save feedback from service', () async {
      when(service.saveFeedback(
              subjetcId: '',
              activityType: '',
              textFeedback: '',
              voiceNote: '',
              timeOfCreation: '',
              boxKey: ''))
          .thenAnswer((_) async => const Right(tUnit));

      final result = await useCase(tSaveFeedback);
      verify(service.saveFeedback(
          subjetcId: '',
          activityType: '',
          textFeedback: '',
          voiceNote: '',
          timeOfCreation: '',
          boxKey: ''));
      expect(result, const Right(tUnit));
    });
  });
}
