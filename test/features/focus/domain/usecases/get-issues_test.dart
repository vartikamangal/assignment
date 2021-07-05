// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/issue.dart';
import 'package:tatsam_app_experimental/features/focus/domain/repositories/focus-repository.dart';
import 'package:tatsam_app_experimental/features/focus/domain/usecases/get-issues.dart';

class MockGetIssuesRepository extends Mock implements FocusRepository {}

void main() {
  MockGetIssuesRepository repository;
  late GetIssues useCase;

  setUp(() {
    repository = MockGetIssuesRepository();
    useCase = GetIssues(repository: repository);
  });

  const tIssues = <Issue>[
    Issue(
      issueId: 1,
      issueIcon: ImageProp(
        urlShort: "https://cdn.tatsam.in/assets/issues/short/1",
        urlLarge: "https://cdn.tatsam.in/assets/issues/medium/1",
        urlMedium: "https://cdn.tatsam.in/assets/issues/large/1",
      ),
      displayName: 'Sleep',
      focusName: 'SLEEP',
      messageOnSelection:
          ' I want to sleep better. More, restful, deeper sleep for my mind and my body',
    ),
    Issue(
      issueId: 1,
      issueIcon: ImageProp(
        urlShort: "https://cdn.tatsam.in/assets/issues/short/1",
        urlLarge: "https://cdn.tatsam.in/assets/issues/medium/1",
        urlMedium: "https://cdn.tatsam.in/assets/issues/large/1",
      ),
      displayName: 'Sleep',
      focusName: 'SLEEP',
      messageOnSelection:
          ' I want to sleep better. More, restful, deeper sleep for my mind and my body',
    ),
    Issue(
      issueId: 1,
      issueIcon: ImageProp(
        urlShort: "https://cdn.tatsam.in/assets/issues/short/1",
        urlLarge: "https://cdn.tatsam.in/assets/issues/medium/1",
        urlMedium: "https://cdn.tatsam.in/assets/issues/large/1",
      ),
      displayName: 'Sleep',
      focusName: 'SLEEP',
      messageOnSelection:
          ' I want to sleep better. More, restful, deeper sleep for my mind and my body',
    ),
  ];

  group('USECASE : getIssues', () {
    test('should return a list of issues using repository', () async {
      //arrange
      when(repository.getIssues())
          .thenAnswer((_) async => const Right(tIssues));
      //act
      final result = await useCase(NoParams());
      //assert
      verify(repository.getIssues());
      expect(result, const Right(tIssues));
    });
  });
}
