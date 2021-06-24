import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/auth/domain/repositories/auth-repository.dart';
import 'package:tatsam_app_experimental/core/auth/domain/usecases/request-logout.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  MockAuthRepository repository;
  RequestLogout useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = RequestLogout(repository: repository);
  });

  final tUnit = unit;
  group('USECASE: requestLogout()', () {
    test('Should logout from the app', () async {
      when(repository.requestLogout()).thenAnswer((_) async => Right(tUnit));

      final result = await useCase(NoParams());

      verify(repository.requestLogout());
      expect(result, Right(tUnit));
    });
  });
}
