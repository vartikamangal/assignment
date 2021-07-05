import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/auth/domain/usecases/request-logout.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

import '../../../core_mock_generator_test.mocks.dart';

void main() {
  late MockAuthRepository repository;
  late RequestLogout useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = RequestLogout(repository: repository);
  });

  const tUnit = unit;
  group('USECASE: requestLogout()', () {
    test('Should logout from the app', () async {
      when(repository.requestLogout())
          .thenAnswer((_) async => const Right(tUnit));

      final Either<Failure, Unit> result = await useCase(NoParams());

      verify(repository.requestLogout());
      expect(result, const Right(tUnit));
    });
  });
}
