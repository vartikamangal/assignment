import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/auth/domain/entities/user-data.dart';
import 'package:tatsam_app_experimental/core/auth/domain/repositories/auth-repository.dart';
import 'package:tatsam_app_experimental/core/auth/domain/usecases/get-user-details.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  MockAuthRepository repository;
  GetUserDetails useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = GetUserDetails(authRepository: repository);
  });

  const tUserData = UserData(
      givenName: '',
      familyName: '',
      nickname: '',
      name: '',
      picture: '',
      locale: '',
      updatedAt: '',
      email: '',
      emailVerified: false,
      iss: '',
      sub: '',
      aud: '',
      iat: 0,
      exp: 0,
      nonce: '');

  group('USECASE: getUserDetails()', () {
    test('Should get user details from the repository', () async {
      //arrange
      when(repository.getUserDetails())
          .thenAnswer((_) async => const Right(tUserData));
      //act
      final result = await useCase(NoParams());
      verify(repository.getUserDetails());
      expect(result, const Right(tUserData));
    });
  });
}
