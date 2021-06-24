import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/auth/domain/entities/request-data.dart';
import 'package:tatsam_app_experimental/core/auth/domain/repositories/auth-repository.dart';
import 'package:tatsam_app_experimental/core/auth/domain/usecases/request-login.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  MockAuthRepository repository;
  RequestLogin useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = RequestLogin(repository: repository);
  });

  const tRequestData =
      RequestData(idToken: '', accessToken: '', refreshToken: '');
  const tIsNewLogin = false;
  group('USECASE: requestLogin()', () {
    test('Should request Login data from the repository', () async {
      when(repository.requestLogin(isNewLogin: tIsNewLogin))
          .thenAnswer((_) async => const Right(tRequestData));

      final result =
          await useCase(const RequestLoginParams(isNewLogin: tIsNewLogin));

      verify(repository.requestLogin(isNewLogin: tIsNewLogin));
      expect(result, const Right(tRequestData));
    });
  });
}
