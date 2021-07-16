import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/home-management/domain/repositories/mood-popup-shown-repository.dart';
import 'package:tatsam_app_experimental/features/home-management/domain/usecases/get-mood-popup-shown-status.dart';
import 'get-mood-popup-shown-status_test.mocks.dart';

@GenerateMocks([MoodPopupShownRepository])
void main() {
  late MockMoodPopupShownRepository repository;
  late GetIsMoodPopupShownStatus useCase;

  const tMoodPopupShownStatus = false;

  setUp(() {
    repository = MockMoodPopupShownRepository();
    useCase = GetIsMoodPopupShownStatus(repository: repository);
  });
  group('USECASE: getMoodPopupShownStatus()', () {
    test('should get mood popup shown status from the repository ...',
        () async {
      when(repository.getMoodPopupShownStatus())
          .thenAnswer((_) async => const Right(tMoodPopupShownStatus));

      final result = await useCase(NoParams());
      verify(repository.getMoodPopupShownStatus());
      expect(result, const Right(tMoodPopupShownStatus));
    });
  });
}
