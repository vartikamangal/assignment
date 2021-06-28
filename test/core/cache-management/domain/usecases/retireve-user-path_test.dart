import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/retrieve-user-path-repository.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/retireve-user-path.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class MockRetrieveUserPathRepository extends Mock
    implements RetrieveUserPathRepository {}

void main() {
  MockRetrieveUserPathRepository repository;
  RetrieveUserPath useCase;

  setUp(() {
    repository = MockRetrieveUserPathRepository();
    useCase = RetrieveUserPath(repository: repository);
  });

  const String tUserPath = '';
  group('USECASE: repository.retrievePath()', () {
    test('should retireve user path from the repository', () async {
      when(repository.retrievePath())
          .thenAnswer((_) async => const Right(tUserPath));

      final result = await useCase(NoParams());
      verify(repository.retrievePath());
      expect(result, const Right(tUserPath));
    });
  });
}
