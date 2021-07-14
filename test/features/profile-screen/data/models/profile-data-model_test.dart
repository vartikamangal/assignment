import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/features/focus/data/models/issue-model.dart';
import 'package:tatsam_app_experimental/features/profile-screen/data/models/profile-data-model.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/entities/profile-data.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/models/journey-model.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tProfileDataModel = ProfileDataModel(
      subjectInformationId: 1,
      travellerId: '',
      holisticScore: 1,
      activitiesThisWeek: 1,
      timeOnActivitiesThisWeek: 1,
      nickName: '',
      focusIssues: [
        IssueModel(
          issueId: null,
          focusName: '',
          displayName: '',
          messageOnSelection: '',
          issueIcon: null,
        )
      ],
      journeyPath: JourneyModel(
          id: 1,
          title: '',
          subtitle: '',
          description: '',
          icon: null,
          pathName: ''));

  group('Model ProfileDataModel', () {
    test('should be a extended version of ProfileData', () async {
      //assert
      expect(tProfileDataModel, isA<ProfileData>());
    });

    test(' .fromJson should return a valid ProfileData', () async {
      //arrange
      final jsonMap =
      jsonDecode(fixtureReader(filename: 'profile-data-model-from.json'))
      as List<dynamic>;
      //act
      final result =
      ProfileDataModel.fromJson(jsonMap.first as Map<String, dynamic>);
      //assert
      expect(result, tProfileDataModel);
    });

    test('toJson should return a properly parsed Map from the model', () async {
      //act
      final result = tProfileDataModel.toJson();
      //assert
      expect(result,
          jsonDecode(fixtureReader(filename: 'profile-data-model-to.json')));
    });
  });
}