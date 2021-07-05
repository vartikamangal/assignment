// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
// Project imports:
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/entites/journey.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/entites/journey_started_success.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/repositories/path-operations-repository.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/usecases/start_journey.dart';

class MockStartJourneyService extends Mock implements PathOperationsRepository {
}

void main() {
  MockStartJourneyService? service;
  late StartJourney useCase;

  setUp(() {
    service = MockStartJourneyService();
    useCase = StartJourney(service: service);
  });

  const tJourney = Journey(
      id: 1,
      title: "Small Wins Path",
      subtitle: "Weekly focus areas. Choose your own experiences.",
      description: "Weekly focus areas. Choose your own experiences.",
      icon: null,
      pathName: "SMALL_WINS");

  group('USECASE : StartJourney', () {
    test('should start the journey with help of service', () async {
      //arrange
      when(service!.startJourney(journey: tJourney))
          .thenAnswer((_) async => Right(SuccessJourneyStart()));
      //act
      await useCase(const StartJourneyParams(journey: tJourney));
      //assert
      verify(service!.startJourney(journey: tJourney));
    });
  });
}
