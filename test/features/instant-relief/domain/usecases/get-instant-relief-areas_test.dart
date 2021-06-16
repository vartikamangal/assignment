// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/entities/instant-relief-area.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/repositories/get-instant-relief-areas-repository.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/usecases/get-instant-relief-areas.dart';

class MockGetInstantReliefAreasRepository extends Mock implements GetInstantReliefAreasRepository {}

void main(){
  MockGetInstantReliefAreasRepository repository;
  GetInstantReliefAreas useCase;
  const tLifeArea=<InstantReliefArea>[
    InstantReliefArea(
        id: 1,
        title: "title",
        subtitle: "subtitle",
        instantReliefName: "instantReliefName",
        description: "description",
        icon: null)
  ];

  setUp(() {
    repository = MockGetInstantReliefAreasRepository();
    useCase = GetInstantReliefAreas(repository: repository);
  });

  group("USECASE : getReliefAreas()", () {
    test('should get all the possible relief areas from the repository', () async {
      //arrange
      when(repository.getReliefAreas())
          .thenAnswer((_) async => const Right(tLifeArea));
      //act
      final result = await useCase(NoParams());
      //assert
      verify(repository.getReliefAreas());
      expect(result, const Right(tLifeArea));
    });
  });
}
