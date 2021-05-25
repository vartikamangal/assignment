import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/repositories/start_journey_service.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/usecases/start_journey.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/entites/journey.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/entites/journey_started_success.dart';

class MockStartJourneyService extends Mock implements StartJourneyService {}

void main(){
  MockStartJourneyService service;
  StartJourney useCase;

  setUp(() {
    service = MockStartJourneyService();
    useCase = StartJourney(service: service);
  });

  final tJourney = Journey(
      id: 1,
      title: "Small Wins Path",
      subtitle: "Weekly focus areas. Choose your own experiences.",
      description: "Weekly focus areas. Choose your own experiences.",
      icon: null,
      pathName: "SMALL_WINS");

  group('USECASE : StartJourney', () {
    test('should start the journey with help of service',
            () async {
          //arrange
          when(service.startJourney(journey: tJourney))
              .thenAnswer((_) async => Right(SuccessJourneyStart()));
          //act
          await useCase(StartJourneyParams(journey: tJourney));
          //assert
          verify(service.startJourney(journey: tJourney));
        });
  });
}
