import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/life-priority-list-model.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/life-priority-list.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tLifePrioritiesModel =
      LifePrioritiesModel(id: 0, areasInOrderOfPriority: ['']);
  group('Model LifePrioritiesModel', () {
    test('should be a extended version of LifePrioritiesModel', () async {
      expect(tLifePrioritiesModel, isA<LifePriorities>());
    });

    test('fromJson should transform raw-response into LifePrioritiesModel',
        () async {
      //arrange
      final jsonMap =
          jsonDecode(fixtureReader(filename: 'life-priorities-model.json'))
              as List<dynamic>;
      //act
      final result =
          LifePrioritiesModel.fromJson(jsonMap.first as Map<String, dynamic>);
      //assert
      expect(result, tLifePrioritiesModel);
    });
  });
}
