// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';

// Project imports:
import 'package:tatsam_app_experimental/features/focus/data/models/issue-model.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/issue.dart';
import '../../../../fixtures/fixture-reader.dart';

// ignore: avoid_relative_lib_imports

void main() {
  final tIssueModel = IssueModel(
    issueId: 1,
    focusName: 'SLEEP',
    displayName: 'Sleep',
    messageOnSelection:
        ' I want to sleep better. More, restful, deeper sleep for my mind and my body',
    issueIcon: ImageModel.fromDomain(
      ImageEntity(
          type: 'URL', url: 'https://images.tatsam.in/Logo+512+x+512.png'),
    ),
  );
  group('Model IssueModel', () {
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
      expect(result.toJson(), tIssueModel.toJson());
    });
    test('toJson should return a properly parsed Map from the model', () async {
      //act
      final result = tIssueModel.toJson();
      //assert
      expect(result, jsonDecode(fixtureReader(filename: 'single-issue.json')));
    });
  });
}
