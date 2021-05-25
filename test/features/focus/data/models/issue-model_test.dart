import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/issue.dart';

// ignore: avoid_relative_lib_imports
import '../../../../../lib/features/focus/data/models/issue-model.dart';
import '../../../../fixtures/fixture-reader.dart';

void main(){
  const tIssueModel =
  IssueModel(
    issueId: 1,
      focusName: "SLEEP",
      displayName: "Sleep",
      messageOnSelection: " I want to sleep better. More, restful, deeper sleep for my mind and my body",
      issueIcon:  ImageProp(
        urlShort: '',
        urlLarge: '',
        urlMedium: '',
      ),
  );
  group('Model IssueModel',(){
    test('should be a extended version of Issue', () async {
      //assert
      expect(tIssueModel, isA<Issue>());
    });

    test(' .fromJson should return a valid Issue', () async {
      //arrange
      final jsonMap = jsonDecode(fixtureReader(filename: 'raw-issues.json'))
      as List<dynamic>;
      //act
      final result = IssueModel.fromJson(jsonMap.first as Map<String, dynamic>);
      //assert
      expect(result, tIssueModel);
    });
    test('toJson should return a properly parsed Map from the model', () async {
      //act
      final result = tIssueModel.toJson();
      //assert
      expect(result, jsonDecode(fixtureReader(filename: 'single-issue.json')));
    });
  });
}