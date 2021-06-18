import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/features/focus/data/models/issue-model.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/entities/profile-data.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/models/journey-model.dart';

class ProfileDataModel extends ProfileData {
  const ProfileDataModel({
    @required int subjectInformationId,
    @required String travellerId,
    @required int holisticScore,
    @required int activitiesThisWeek,
    @required int timeOnActivitiesThisWeek,
    @required String nickName,
    @required List<IssueModel> focusIssues,
    @required JourneyModel journeyPath,
  }) : super(
          timeOnActivitiesThisWeek: timeOnActivitiesThisWeek,
          travellerId: travellerId,
          activitiesThisWeek: activitiesThisWeek,
          journeyPath: journeyPath,
          focusIssues: focusIssues,
          nickName: nickName,
          holisticScore: holisticScore,
          subjectInformationId: subjectInformationId,
        );

  factory ProfileDataModel.fromJson(Map<String, dynamic> jsonMap) {
    return ProfileDataModel(
      subjectInformationId: jsonMap['subjectInformationId'] as int,
      travellerId: jsonMap['travellerId'] as String,
      holisticScore: jsonMap['holisticScore'] as int,
      activitiesThisWeek: jsonMap['activitiesThisWeek'] as int,
      timeOnActivitiesThisWeek: jsonMap['timeOnActivitiesThisWeek'] as int,
      nickName: jsonMap['nickName'] as String,
      focusIssues: (jsonMap['focusIssues'] as List)
          .map((issue) => IssueModel.fromJson(issue as Map<String, dynamic>))
          .toList(),
      journeyPath: JourneyModel.fromJson(
        jsonMap['journeyPath'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "subjectInformationId": subjectInformationId,
      "travellerId": travellerId,
      "holisticScore": holisticScore,
      "activitiesThisWeek": activitiesThisWeek,
      "timeOnActivitiesThisWeek": timeOnActivitiesThisWeek,
      "nickName": nickName,
      "focusIssues": focusIssues
          .map(
            (issueModel) => issueModel.toJson(),
          )
          .toList(),
      "journeyPath": journeyPath.toJson()
    };
  }
}
