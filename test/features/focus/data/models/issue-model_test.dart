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
    issueIcon: null,
  );
  group('Model IssueModel', () {
    test('should be a extended version of Issue', () async {
      //assert
      expect(tIssueModel, isA<Issue>());
    });
  });
}
