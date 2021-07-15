// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/add-issue-success.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/issue.dart';
import 'package:tatsam_app_experimental/features/focus/domain/repositories/focus-repository.dart';
import 'package:tatsam_app_experimental/features/focus/domain/usecases/add-issue.dart';

import 'add-issue_test.mocks.dart';

@GenerateMocks([FocusRepository])
void main() {
  late MockFocusRepository service;
  late SetTarget useCase;

  setUp(() {
    service = MockFocusRepository();
    useCase = SetTarget(service: service);
  });

  const tIssue = Issue(
    issueId: 1,
    issueIcon: null,
    displayName: 'Sleep',
    focusName: 'Sleep',
    messageOnSelection: 'I want to reduce stress',
  );

  final tSuccess = AddIssueSuccess();

  group('USECASE : setTarget', () {
    test('should set the user_targets with the help of service', () async {
      //arrange
      when(service.setTarget(issue: tIssue))
          .thenAnswer((_) async => Right(tSuccess));
      //act
      final result = await useCase(const SetTargetParams(issue: tIssue));
      //assert
      verify(service.setTarget(issue: tIssue));
      expect(result, Right(tSuccess));
    });
  });
}
