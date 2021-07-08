import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/duration-tracker/data/models/app-duration-model.dart';
import 'package:tatsam_app_experimental/core/duration-tracker/domain/entities/app-duration.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  final tAppDurationModel = AppDurationModel(
      lastLogin: DateTime.parse('2021-05-10T13:19:41.543Z'), currentWeekday: 1);
  group('Model AppDurationModel', () {
    test('should be a extended version of AppDuration', () async {
      expect(tAppDurationModel, isA<AppDuration>());
    });

    test('fromJson should transform raw-response into AppDurationModel',
        () async {
      //arrange
      final jsonMap =
          jsonDecode(fixtureReader(filename: 'app-duration-model.json'))
              as Map<String, dynamic>;
      //act
      final result = AppDurationModel.frmoJson(jsonMap);
      //assert
      expect(result, tAppDurationModel);
    });
  });
}
