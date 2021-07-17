import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/features/focus/data/models/issue-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/hub-status-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/life-priority-list-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/target-focus-list-model.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/hub-status.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-information-model.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tSubjectIdModel = SubjectIdModel(id: 'id');

  const tSubjectInformationModel = SubjectInformationModel(
      subjectId: tSubjectIdModel,
      userID: null,
      name: 'name',
      nickName: 'nickName',
      deviceIndentifier: null,
      gender: null);

  final tIssue = IssueModel(
      issueId: null,
      issueIcon: null,
      displayName: 'displayName',
      focusName: 'focusName',
      messageOnSelection: 'messageOnSelection');

  final tTargetFocus = TargetFocusListModel(id: 1, targetFocusList: [tIssue]);

  const tLifePriorities = LifePrioritiesModel(
      id: 1, areasInOrderOfPriority: ['areasInOrderOfPriority']);
  final tHubStatusModel = HubStatusModel(
      id: 1,
      subjectInformation: tSubjectInformationModel,
      targetFocus: tTargetFocus,
      lifePriorities: tLifePriorities,
      lifeSatisfactionRatings: {},
      attemptedQuestions: false,
      journeyPath: null,
      journeyStartedAt: null,
      journeyStatus: '',
      latestMood: "neutral");
  group('Model HubStatusModel', () {
    test('should be a extended version of HubStatus', () async {
      expect(tHubStatusModel, isA<HubStatus>());
    });
  });
}
