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
      SubjectIdModel(id: 'b0d388a5-78e5-4520-a137-41336265c978');

  group("MODEL SubjectIdModel :", () {
    test('SubjectIdModel is a exttended version of SubjectId.', () async {
      //assert
      expect(tsubjectIdModel, isA<SubjectId>());
    });
    test('fromJson should return a SubjectIdModel', () async {
      //arrange
      final Map<String, dynamic> jsonMap = jsonDecode(
        fixtureReader(filename: 'create-rapport-building-user-response.json'),
      ) as Map<String, dynamic>;
      //act
      final result = SubjectIdModel.fromJson(
        jsonMap: jsonMap['subjectId'] as Map<String, dynamic>,
      );
      //assert
      expect(result, tsubjectIdModel);
    });
    test('toJson should return a jsonMap obtained from SubjectIdModel',
        () async {
      //arrange
      final Map<String, dynamic> jsonMap = {
        "id": tsubjectIdModel.id,
      };
      //act
      final result = tsubjectIdModel.toJson();
      //assert
      expect(result, jsonMap);
    });
  });
}
