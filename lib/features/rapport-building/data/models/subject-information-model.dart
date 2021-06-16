// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import '../../domain/entities/subject-information.dart';
import 'subject-id-model.dart';

class SubjectInformationModel extends SubjectInformation {
  @override
  const SubjectInformationModel({
    @required SubjectIdModel subjectId,
    @required String userID,
    @required String name,
    @required String nickName,
    @required String deviceIndentifier,
    @required Gender gender,
  }) : super(
          deviceIndentifier: deviceIndentifier,
          name: name,
          subjectId: subjectId,
          userID: userID,
          nickName: nickName,
          gender: gender,
        );

  factory SubjectInformationModel.fromJson(Map<String, dynamic> jsonMap) {
    return SubjectInformationModel(
      subjectId: SubjectIdModel.fromJson(
          jsonMap: jsonMap['subjectId'] as Map<String, dynamic>),
      userID: jsonMap["userId"] as String,
      name: jsonMap["name"] as String,
      nickName: jsonMap["nickName"] as String,
      deviceIndentifier: jsonMap["deviceIdentifier"] as String,
      gender: _getGender(jsonMap["gender"] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "subjectId": {
        "id": subjectId.id,
      },
      "userId": userID,
      "name": name,
      "nickName": nickName,
      "gender": gender,
      "deviceIdentifier": deviceIndentifier,
    };
  }
}

Gender _getGender(String genderRaw) {
  if (genderRaw == "Male") {
    return Gender.Male;
  }
  if (genderRaw == "Female") {
    return Gender.Female;
  } else {
    return null;
  }
}
