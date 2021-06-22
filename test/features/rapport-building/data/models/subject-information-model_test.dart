// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-information-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-information.dart';
import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tSubjectInfo = SubjectInformationModel(
    subjectId: SubjectIdModel(id: "b0d388a5-78e5-4520-a137-41336265c978"),
    userID: "ed598e21-dcf3-4f3a-bc0d-9079f372d603",
    name: null,
    nickName: "Bhavna",
    deviceIndentifier: "Here_is_a_random_identifier",
    // ignore: avoid_redundant_argument_values
    gender: null,
  );
  group("MODEL SubjectInformationModel :", () {
    test('should be a extended version of SubjectInformation', () async {
      //assert
      expect(tSubjectInfo, isA<SubjectInformation>());
    });
    test(' .fromJson() should give a valid SubjectInformationModel', () async {
      //arrange
      final Map<String, dynamic> jsonMap = jsonDecode(fixtureReader(
              filename: 'create-rapport-building-user-response.json'))
          as Map<String, dynamic>;
      //act
      final result = SubjectInformationModel.fromJson(jsonMap);
      //assert
      expect(result, tSubjectInfo);
    });
    test('toJsoon() should give a decoded Map<String,dynamic>', () async {
      //arrange
      final Map<String, dynamic> json = {
        "subjectId": {"id": "b0d388a5-78e5-4520-a137-41336265c978"},
        "userId": "ed598e21-dcf3-4f3a-bc0d-9079f372d603",
        "name": null,
        "nickName": "Bhavna",
        "gender": null,
        "deviceIdentifier": "Here_is_a_random_identifier"
      };
      //act
      final result = tSubjectInfo.toJson();
      //assert
      expect(result, json);
    });
  });
}
