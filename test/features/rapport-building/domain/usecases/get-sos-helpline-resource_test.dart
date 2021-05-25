import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/sos-resource.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/get-sos-helpline-resource_repository.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/usecases/get-sos-helpline-resource.dart';

class MockGetSoSHelplineResourceRepository extends Mock
    implements GetSOSResourceReporsitory {}

void main() {
  MockGetSoSHelplineResourceRepository repository;
  GetSoSHelplineResource useCase;

  const tSoSResource = SoSResource(
    sosHelplineId: 2,
    contactInfos: [
      '+91-8273645166',
      '+91-8273645166',
      '+91-8273645166',
      '+91-8273645166',
    ],
  );
  group('USECASE : getSoSResource', () {
    setUp(() {
      repository = MockGetSoSHelplineResourceRepository();
      useCase = GetSoSHelplineResource(repository: repository);
    });
    test('should get the list of gov. helpline numbers', () async {
      //arrange
      when(repository.getSosResource())
          .thenAnswer((_) async => const Right(tSoSResource));
      //act
      final result = await useCase(NoParams());
      //assert
      expect(result, const Right(tSoSResource));
    });
  });
}
