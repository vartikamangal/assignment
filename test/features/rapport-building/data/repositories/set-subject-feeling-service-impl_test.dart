import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/repository/set-subject-feeling-service-impl.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/sources/set-subject-feeling-local-service.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/set-feeling-success.dart';

class MockSetSubjectFeelingLocalService extends Mock
    implements SetSubjectFeelingLocalService {}

void main() {
  MockSetSubjectFeelingLocalService localService;
  SetSubjectFeelingServiceImpl serviceImpl;

  setUp(() {
    localService = MockSetSubjectFeelingLocalService();
    serviceImpl = SetSubjectFeelingServiceImpl(localService: localService);
  });

  const tFeeling =
      "Hey I am feeling good. But sometimes just concious of my health.";

  group('DEVICE OFFLINE : SetSubjectFeelingService', () {
    test('should save the user-feeling locally', () async {
      //arrange
      when(localService.setFeeling(feeling: tFeeling)).thenAnswer(
        (_) async => SetFeelingSuccess(),
      );
      //act
      final result = await serviceImpl.setSubjectFeeling(tFeeling);
      //assert
      verify(localService.setFeeling(feeling: tFeeling));
      expect(result, Right(SetFeelingSuccess()));
    });
    test('should return CacheFailure when not able to persist the data locally',
        () async {
      //arrange
      when(localService.setFeeling(feeling: tFeeling))
          .thenThrow(CacheException());
      //act
      final result = await serviceImpl.setSubjectFeeling(tFeeling);
      //assert
      expect(result, Left(CacheFailure()));
    });
  });
}
