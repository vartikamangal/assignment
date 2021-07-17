import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/features/focus/data/models/issue-model.dart';
import 'package:tatsam_app_experimental/features/profile-screen/data/models/profile-data-model.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/entities/profile-data.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/models/journey-model.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  final tProfileDataModel = ProfileDataModel(
      subjectInformationId: 24944,
      travellerId: 'd0ba7d82-ad7f-4a1f-902c-8da2629f2369',
      holisticScore: 1,
      activitiesThisWeek: 1,
      timeOnActivitiesThisWeek: 15,
      nickName: 'dsfsd',
      focusIssues: <IssueModel>[
        IssueModel(
            issueId: 1,
            focusName: 'SLEEP',
            displayName: 'Sleep',
            messageOnSelection:
                'I want to sleep better. More, restful, deeper sleep for my mind and my body',
            issueIcon: ImageModel.fromDomain(ImageEntity(
                type: 'png',
                url: 'https://images.tatsam.in/Logo+512+x+512.png')))
      ],
      journeyPath: JourneyModel(
          id: 1,
          title: 'Small Wins Path',
          subtitle: 'Weekly focus areas. Choose your own experiences.',
          description:
              'Only one area of focus per week, Daily small wins at your own pace',
          icon: ImageModel.fromDomain(ImageEntity(
              type: 'png', url: 'https://images.tatsam.in/Logo+512+x+512.png')),
          pathName: 'SMALL_WINS'));

  group('Model ProfileDataModel', () {
    test('should be a extended version of ProfileData', () async {
      //assert
      expect(tProfileDataModel, isA<ProfileData>());
    });
    // test(' .fromJson should return a valid profile data', () async {
    //   //arrange
    //   final jsonMap = jsonDecode(fixtureReader(filename: 'raw-profile-data-model.json'))
    //   as List<dynamic>;
    //   //act
    //   final result = ProfileDataModel.fromJson(jsonMap.first as Map<String, dynamic>);
    //   //assert
    //   expect(result.toJson(), tProfileDataModel.toJson());
    // });
    test('toJson should return a properly parsed Map from the model', () async {
      //act
      final result = tProfileDataModel.toJson();
      //assert
      expect(result,
          jsonDecode(fixtureReader(filename: 'raw-profile-data-model.json')));
    });
  });
}
