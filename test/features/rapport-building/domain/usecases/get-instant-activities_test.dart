// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/quick-action.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/get-instant-activities-repository.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/usecases/get-instant-activities.dart';

class MockGetInstantActivitiesRepository extends Mock
    implements GetInstantActivitiesRepository {}

void main() {
  MockGetInstantActivitiesRepository repository;
  GetInstantActivities useCase;

  setUp(() {
    repository = MockGetInstantActivitiesRepository();
    useCase = GetInstantActivities(repository: repository);
  });

  const tQuickActions = <QuickAction>[
    QuickAction(
      quickActionID: 1,
      icon: ImageProp(
        urlLarge: 'http://cdn.tatsam.in/assets/large/qaction/1',
        urlMedium: 'http://cdn.tatsam.in/assets/medium/qaction/1',
        urlShort: 'http://cdn.tatsam.in/assets/small/qaction/1',
      ),
      title: 'Feeling Overwhelmed',
      description: 'Do this that this that',
    ),
    QuickAction(
      quickActionID: 2,
      icon: ImageProp(
        urlLarge: 'http://cdn.tatsam.in/assets/large/qaction/2',
        urlMedium: 'http://cdn.tatsam.in/assets/medium/qaction/2',
        urlShort: 'http://cdn.tatsam.in/assets/small/qaction/2',
      ),
      title: 'Feeling Overwhelmed',
      description: 'Do this that this that',
    ),
    QuickAction(
      quickActionID: 3,
      icon: ImageProp(
        urlLarge: 'http://cdn.tatsam.in/assets/large/qaction/3',
        urlMedium: 'http://cdn.tatsam.in/assets/medium/qaction/3',
        urlShort: 'http://cdn.tatsam.in/assets/small/qaction/3',
      ),
      title: 'Feeling Overwhelmed',
      description: 'Do this that this that',
    ),
  ];

  group('USECASE : getInstantActivities', () {
    test('''
            should get some quick-actions 
            for user to get instant relief''', () async {
      //arrange
      when(repository.getInstantActivities())
          .thenAnswer((_) async => const Right(tQuickActions));
      //act
      final result = await useCase(NoParams());
      //assert
      verify(repository.getInstantActivities());
      expect(result, const Right(tQuickActions));
    });
  });
}
