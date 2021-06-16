// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-id.dart';
import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tsubjectIdModel =
      SubjectIdModel(id: '5a58e827-7c69-4bcc-b40d-5e5c12c5e956');

  group("MODEL SubjectIdModel :", () {
    test('SubjectIdModel is a exttended version of SubjectId.', () async {
      //assert
      expect(tsubjectIdModel, isA<SubjectId>());
    });
    test('SubjectIdModel.fromJson should return a SubjectIdModel', () async {
      //arrange
      final Map<String, dynamic> jsonMap = jsonDecode(fixtureReader(
              filename: 'create-rapport-building-user-response.json'))
          as Map<String, dynamic>;
      //act
      final result = SubjectIdModel.fromJson(
          jsonMap: jsonMap['subjectId'] as Map<String, dynamic>);
      //assert
      expect(result, tsubjectIdModel);
    });
    test('toJson should return a jsonMap obtained from SubjectIdModel',
        () async {
      //arrange
      const Map<String, dynamic> jsonMap = {
        "id": "5a58e827-7c69-4bcc-b40d-5e5c12c5e956"
      };
      //act
      final result = tsubjectIdModel.toJson();
      //assert
      expect(result, jsonMap);
    });
  });
}
