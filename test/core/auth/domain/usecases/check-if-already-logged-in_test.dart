import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/auth/domain/repositories/auth-repository.dart';
import 'package:tatsam_app_experimental/core/auth/domain/usecases/check-if-already-logged-in.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  MockAuthRepository repository;
  CheckIfAlreadyLoggedIn useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = CheckIfAlreadyLoggedIn(repository: repository);
  });

  const tLogged = false;
  group("USECASE : checkIfAlreadyLoggedIn", () {
    test('Should check if user already logged in', () async {
      //arrange
      when(repository.checkIfAlreadyLoggedIn())
          .thenAnswer((_) async => const Right(tLogged));
      //act
      final result = await useCase(NoParams());
      //assert
      verify(repository.checkIfAlreadyLoggedIn());
      expect(result, const Right(tLogged));
    });
  });
}
