import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/auth/domain/usecases/check-if-already-logged-in.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

import '../../../core_mock_generator_test.mocks.dart';

void main() {
  late MockAuthRepository repository;
  late CheckIfAuthenticated useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = CheckIfAuthenticated(repository: repository);
  });

  const tLogged = false;
  group("USECASE : checkIfAlreadyLoggedIn", () {
    test('Should check if user already logged in', () async {
      //arrange
      when(repository.checkIfAuthenticated())
          .thenAnswer((_) async => const Right(tLogged));
      //act
      final Either<Failure, bool> result = await useCase(NoParams());
      //assert
      verify(repository.checkIfAuthenticated());
      expect(result, const Right(tLogged));
    });
  });
}
