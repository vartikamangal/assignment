import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/home-management/domain/repositories/mood-popup-shown-repository.dart';
import 'package:tatsam_app_experimental/features/home-management/domain/usecases/toggle-mood-popup-shown-state.dart';
import 'toggle-mood-popup-shown-state_test.mocks.dart';

@GenerateMocks([MoodPopupShownRepository])

void main() {
  late MockMoodPopupShownRepository repository;
  late ToggleMoodPopupShownState useCase;

  const tUnit = unit;

  setUp(() {
    repository = MockMoodPopupShownRepository();
    useCase = ToggleMoodPopupShownState(repository: repository);
  });
  group('USECASE: toogleIsMoodPopupShownState()', () {
    test('should toggle mood popup shown state from repository ...', () async {
      when(repository.toogleIsMoodPopupShownState())
          .thenAnswer((_) async => const Right(tUnit));

      final result = await useCase(NoParams());
      verify(repository.toogleIsMoodPopupShownState());
      expect(result, const Right(tUnit));
    });
  });
}
