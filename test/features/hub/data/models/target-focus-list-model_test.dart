import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/target-focus-list-model.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/target-focus-list.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tTargetFocusListModel =
      TargetFocusListModel(id: 1, targetFocusList: []);
  group('Model TargetFocusListModel', () {
    test('should be a extended version of TargetFocusList', () async {
      expect(tTargetFocusListModel, isA<TargetFocusList>());
    });

    test('fromJson should transform raw-response into TargetFocusListModel',
        () async {
      //arrange
      final jsonMap =
          jsonDecode(fixtureReader(filename: 'target-focus-list-model.json'))
              as List<dynamic>;
      //act
      final result =
          TargetFocusListModel.fromJson(jsonMap.first as Map<String, dynamic>);
      //assert
      expect(result, tTargetFocusListModel);
    });
  });
}
