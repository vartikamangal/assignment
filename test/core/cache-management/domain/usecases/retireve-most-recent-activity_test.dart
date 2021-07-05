import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/retrieve-most-recent-activity-repository.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/retireve-most-recent-activity.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

import 'retireve-most-recent-activity_test.mocks.dart';

@GenerateMocks([RetrieveMostRecentAcitivityRepository])
void main() {
  late MockRetrieveMostRecentAcitivityRepository repository;
  late RetrieveMostRecentActivity useCase;

  setUp(() {
    repository = MockRetrieveMostRecentAcitivityRepository();
    useCase = RetrieveMostRecentActivity(repository: repository);
  });
  const tActivity =
      CacheAcitivityModel(id: '', title: '', subtitle: '', icon: '');
  group('USECASE: repository.retrieveActivity()', () {
    test('Should retireve most recent activity from the repository', () async {
      when(repository.retrieveActivity())
          .thenAnswer((_) async => const Right(tActivity));

      final result = await useCase(NoParams());
      verify(repository.retrieveActivity());
      expect(result, const Right(tActivity));
    });
  });
}
