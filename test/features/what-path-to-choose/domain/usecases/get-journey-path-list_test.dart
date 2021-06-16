// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/entites/journey.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/repositories/get_journey_path_list_repository.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/usecases/get-journey-path-list.dart';

class MockGetIssuesRepository extends Mock implements GetJounreyPathListRepository {}

void main(){
  MockGetIssuesRepository repository;
  GetJourneyPathList useCase;

  setUp(() {
    repository = MockGetIssuesRepository();
    useCase = GetJourneyPathList(repository: repository);
  });

  const tJourneyPath = <Journey>[
    Journey(
      id: 1,
      title: "Small Wins Path",
      subtitle: "Weekly focus areas. Choose your own experiences.",
      description: "Weekly focus areas. Choose your own experiences.",
      icon: null,
      pathName: "SMALL_WINS"),
  ];
  group('USECASE : getIssues', () {
    test('should return a list of Journey using repository', () async {
      //arrange
      when(repository.getJourneyPaths())
          .thenAnswer((_) async => const Right(tJourneyPath));
      //act
      final result = await useCase(NoParams());
      //assert
      verify(repository.getJourneyPaths());
      expect(result, const Right(tJourneyPath));
    });
  });
}
