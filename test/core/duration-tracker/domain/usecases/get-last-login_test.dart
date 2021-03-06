// Package Imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
// Project Imports:
import 'package:tatsam_app_experimental/core/duration-tracker/domain/entities/app-duration.dart';
import 'package:tatsam_app_experimental/core/duration-tracker/domain/repository/app-duration-repository.dart';
import 'package:tatsam_app_experimental/core/duration-tracker/domain/usecases/get-last-login.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class MockAppDurationRepository extends Mock implements AppDurationRepository {}

void main() {
  MockAppDurationRepository repository;
  GetLastLogin useCase;

  setUp(() {
    repository = MockAppDurationRepository();
    useCase = GetLastLogin(repository: repository);
  });

  final tAppDuration = AppDuration(
      lastLogin: DateTime.parse('2021-06-22 11:28:21.579021'),
      currentWeekday: 1);
  group("USECASE : getLastLogin()", () {
    test('should get last login timestamp from the repository', () async {
      //arrange
      when(repository.getLastLogin())
          .thenAnswer((_) async => Right(tAppDuration));
      //act
      final result = await useCase(NoParams());
      //assert
      verify(repository.getLastLogin());
      expect(result, Right(tAppDuration));
    });
  });
}
