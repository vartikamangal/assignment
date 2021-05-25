import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/set-feeling-success.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/set-user-feeling-service.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/usecases/set-subject-feeling.dart';

class MockSetSubjectFeelingService extends Mock
    implements SetSubjectFeelingService {}

void main() {
  MockSetSubjectFeelingService setSubjectFeelingService;
  SetSubjectFeeling useCase;

  final tSuccess = SetFeelingSuccess();
  const tFeeling =
      "I am a very cheerful person in general, But sometimes feel a quite low.";

  setUp(() {
    setSubjectFeelingService = MockSetSubjectFeelingService();
    useCase = SetSubjectFeeling(service: setSubjectFeelingService);
  });

  group('USECASE : setSubjectFeeling', () {
    test(
        'should set the current feeling of user on [API/LOCAL] and return SetFeelingSuccess',
        () async {
      //arrange
      when(setSubjectFeelingService.setSubjectFeeling(tFeeling))
          .thenAnswer((_) async => Right(tSuccess));
      //act
      final result =
          await useCase(const SetSubjectFeelingParams(feeling: tFeeling));
      //assert
      expect(result, Right(tSuccess));
    });
  });
}
