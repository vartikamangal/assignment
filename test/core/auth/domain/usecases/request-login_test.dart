import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/auth/domain/entities/oauth-data.dart';
import 'package:tatsam_app_experimental/core/auth/domain/usecases/oauth-login.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

import '../../../core_mock_generator_test.mocks.dart';

void main() {
  late MockAuthRepository repository;
  late OauthLogin useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = OauthLogin(repository: repository);
  });

  const tRequestData =
      OAuthData(idToken: '', accessToken: '', refreshToken: '');
  group('USECASE: requestLogin()', () {
    test('Should request Login data from the repository', () async {
      when(
        repository.oauthLogin(),
      ).thenAnswer((_) async => const Right(tRequestData));

      final Either<Failure, OAuthData> result = await useCase(NoParams());

      verify(repository.oauthLogin());
      expect(result, const Right(tRequestData));
    });
  });
}
