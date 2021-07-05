import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/duration-tracker/data/models/app-duration-model.dart';
import 'package:tatsam_app_experimental/core/duration-tracker/data/repositories/app-duration-repository-impl.dart';
import 'package:tatsam_app_experimental/core/duration-tracker/data/sources/app-duration-local-data-source.dart';

import 'app-duration-repository-impl_test.mocks.dart';

@GenerateMocks([AppDurationLocalDataSource])
void main() {
  late MockAppDurationLocalDataSource? localDataSource;
  late AppDurationRepositoryImpl repositoryImpl;

  setUp(() {
    localDataSource = MockAppDurationLocalDataSource();
    repositoryImpl =
        AppDurationRepositoryImpl(localDataSource: localDataSource);
  });

  final tAppDurationModel =
      AppDurationModel(lastLogin: DateTime.now(), currentWeekday: 1);

  group('USECASE: getLastLogin()', () {
    test('should return last login timestamp', () async {
      //arrange
      when(localDataSource!.getLastLogin())
          .thenAnswer((_) async => tAppDurationModel);
      //act
      final result = await repositoryImpl.getLastLogin();
      //assert
      verify(localDataSource!.getLastLogin());
      expect(result, Right(tAppDurationModel));
    });
  });
}
