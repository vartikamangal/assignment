import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/life-area.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/repositories/get-life-areas-repository.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/usecases/get-life-areas.dart';

class MockGetLifeAreasRepository extends Mock
    implements GetLifeAreasRepository {}

void main() {
  MockGetLifeAreasRepository repository;
  GetLifeAreas useCase;

  setUp(() {
    repository = MockGetLifeAreasRepository();
    useCase = GetLifeAreas(repository: repository);
  });

  const tLifeAreas = <LifeArea>[
    LifeArea(areaCode: 'CON', name: 'Connection', description: 'Connection'),
    LifeArea(
        areaCode: 'REL', name: 'Relationship', description: 'Relationship'),
    LifeArea(
        areaCode: 'CONTRIB', name: 'Contribution', description: 'Contribution'),
    LifeArea(areaCode: 'GROW', name: 'Growth', description: 'Growth'),
    LifeArea(areaCode: 'WLT', name: 'Wealth', description: 'Wealth'),
    LifeArea(
        areaCode: 'RRS',
        name: 'Romantic Relationship',
        description: 'Romantic Relationship'),
    LifeArea(
        areaCode: 'SRR',
        name: 'Self Relationship',
        description: 'Self Relationship'),
    LifeArea(areaCode: 'SPR', name: 'Sprituality', description: 'Sprituality'),
  ];

  group('USECASE : getLifeAreas()', () {
    test('should get a List<LifeArea> from the repository', () async {
      //arrange
      when(repository.getLifeAreas())
          .thenAnswer((_) async => const Right(tLifeAreas));
      //act
      final result = await useCase(NoParams());
      //assert
      verify(repository.getLifeAreas());
      expect(result, const Right(tLifeAreas));
    });
  });
}
