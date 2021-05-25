import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/journey-set-success.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/journey-type.dart';
import 'package:tatsam_app_experimental/features/hub/domain/repository/select-journey-type-service.dart';
import 'package:tatsam_app_experimental/features/hub/domain/usecases/select-journey-type.dart';

class MockSelectJourneyTypeService extends Mock
    implements SelectJourneyTypeService {}

void main() {
  MockSelectJourneyTypeService service;
  SelectJourneyType useCase;

  setUp(() {
    service = MockSelectJourneyTypeService();
    useCase = SelectJourneyType(service: service);
  });

  const tJourneyType = JourneyType.GUIDED;
  final tSuccess = JourneySetSuccess();

  group("USECASE : selectJourneyType", () {
    test('should set the Journey of user with the help of service', () async {
      //arrange
      when(service.selectJourney(journeyType: tJourneyType))
          .thenAnswer((_) async => Right(tSuccess));
      //act
      final result = await useCase(
          const SelectJourneyTypeParams(journeyType: tJourneyType));
      //assert
      verify(service.selectJourney(journeyType: tJourneyType));
      expect(result, Right(tSuccess));
    });
  });
}
