import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-information-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-information.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tSubjectInfo = SubjectInformationModel(
    subjectId: SubjectIdModel(id: "5a58e827-7c69-4bcc-b40d-5e5c12c5e956"),
    userID: "f43d2341-e0c9-4219-bb6d-252ddd3be26b",
    name: null,
    nickName: "Test User",
    deviceIndentifier: "THIS_IS_A_RANDOM_DEVICE_IDENTIFIER",
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
        "subjectId": {"id": "5a58e827-7c69-4bcc-b40d-5e5c12c5e956"},
        "userId": "f43d2341-e0c9-4219-bb6d-252ddd3be26b",
        "name": null,
        "nickName": "Test User",
        "gender": null,
        "deviceIdentifier": "THIS_IS_A_RANDOM_DEVICE_IDENTIFIER"
      };
      //act
      final result = tSubjectInfo.toJson();
      //assert
      expect(result, json);
    });
  });
}
