// Package Imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/auth/domain/entities/oauth-data.dart';
import 'package:tatsam_app_experimental/core/auth/domain/usecases/request-new-token.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

import '../../../core_mock_generator_test.mocks.dart';

void main() {
  late MockAuthRepository repository;
  late RequestNewToken useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = RequestNewToken(repository: repository);
  });
  const tRequestData =
      OAuthData(idToken: '', accessToken: '', refreshToken: '');
  group('USECASE: requestNewToken()', () {
    test('Should request new token from the repository', () async {
      when(repository.requestNewToken())
          .thenAnswer((_) async => const Right(tRequestData));

      final Either<Failure, OAuthData> result = await useCase(NoParams());
      verify(repository.requestNewToken());
      expect(result, const Right(tRequestData));
    });
  });
}
