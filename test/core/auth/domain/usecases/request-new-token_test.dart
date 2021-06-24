// Package Imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
// Project Imports:
import 'package:tatsam_app_experimental/core/auth/domain/entities/request-data.dart';
import 'package:tatsam_app_experimental/core/auth/domain/repositories/auth-repository.dart';
import 'package:tatsam_app_experimental/core/auth/domain/usecases/request-new-token.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  MockAuthRepository repository;
  RequestNewToken useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = RequestNewToken(repository: repository);
  });
  const tRequestData =
      RequestData(idToken: '', accessToken: '', refreshToken: '');
  group('USECASE: requestNewToken()', () {
    test('Should request new token from the repository', () async {
      when(repository.requestNewToken())
          .thenAnswer((_) async => const Right(tRequestData));

      final result = await useCase(NoParams());
      verify(repository.requestNewToken());
      expect(result, const Right(tRequestData));
    });
  });
}
