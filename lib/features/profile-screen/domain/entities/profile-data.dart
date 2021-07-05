import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../focus/data/models/issue-model.dart';
import '../../../what-path-to-choose/data/models/journey-model.dart';

class ProfileData extends Equatable {
  final int? subjectInformationId;
  final String? travellerId;
  final int? holisticScore;
  final int? activitiesThisWeek;
  final int? timeOnActivitiesThisWeek;
  final String? nickName;
  final List<IssueModel> focusIssues;
  final JourneyModel journeyPath;

  const ProfileData({
    required this.subjectInformationId,
    required this.travellerId,
    required this.holisticScore,
    required this.activitiesThisWeek,
    required this.timeOnActivitiesThisWeek,
    required this.nickName,
    required this.focusIssues,
    required this.journeyPath,
  });

  @override
  List<Object?> get props => [
        subjectInformationId,
        travellerId,
        holisticScore,
        activitiesThisWeek,
        timeOnActivitiesThisWeek,
        nickName,
        focusIssues,
        journeyPath,
      ];
}
