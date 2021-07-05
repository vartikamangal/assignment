import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/success-create-traveller.dart';
import 'package:tatsam_app_experimental/features/hub/domain/repository/create-traveller-service.dart';
import 'package:tatsam_app_experimental/features/hub/domain/usecases/create-travller.dart';

class MockCreateTravellerRepository extends Mock
    implements CreateTravellerService {}

void main() {
  MockCreateTravellerRepository repository;
  late CreateTraveller usecase;

  setUp(() {
    repository = MockCreateTravellerRepository();
    usecase = CreateTraveller(service: repository);
  });

  const tSuccess = SuccessCreatedTraveller();

  group('Usecase: Create Traveller', () {
    test('should create the traveller with the help of provided repository',
        () async {
      //arrange
      when(repository.createTraveller())
          .thenAnswer((_) async => const Right(tSuccess));
      //act
      final result = await usecase(NoParams());
      //assert
      verify(repository.createTraveller());
      expect(result, const Right(tSuccess));
    });
  });
}
