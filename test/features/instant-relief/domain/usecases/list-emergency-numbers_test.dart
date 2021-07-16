// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/entities/emergency-number.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/repositories/instant-relief-repository.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/usecases/list-emergency-numbers.dart';
import 'list-emergency-numbers_test.mocks.dart';

@GenerateMocks([InstantReliefRepository])
void main() {
  late MockInstantReliefRepository repository;
  late ListEmergencyNumbers useCase;
  const tEmergencyNumberList = <EmergencyNumber>[
    EmergencyNumber(number: "55625666555"),
  ];

  setUp(() {
    repository = MockInstantReliefRepository();
    useCase = ListEmergencyNumbers(repository: repository);
  });

  group("USECASE : ListEmergencyNumber()", () {
    test('should get all the possible emergency number from the repository',
        () async {
      //arrange
      when(repository.fetchEmergencyNumbers())
          .thenAnswer((_) async => const Right(tEmergencyNumberList));
      //act
      final result = await useCase(NoParams());
      //assert
      verify(repository.fetchEmergencyNumbers());
      expect(result, const Right(tEmergencyNumberList));
    });
  });
}
