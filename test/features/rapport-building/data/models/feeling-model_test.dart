import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/feeling-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/feeling.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tFeeling =
      "Hey I am feeling good. But sometimes just concious of my health.";
  const tFeelingModel = FeelingModel(
    feeling: tFeeling,
  );

  group('Model FeelingModel ', () {
    test('should be an extendor of Feeling', () async {
      //assert
      expect(tFeelingModel, isA<Feeling>());
    });
    test('fromJson should transform raw-response into FeelingModel', () async {
      //arrange
      final jsonMap = jsonDecode(fixtureReader(filename: 'feeling-raw.json'))
          as Map<String, dynamic>;
      //act
      final result = FeelingModel.fromJson(jsonMap);
      //assert
      expect(result, tFeelingModel);
    });
    test('toJson should transform the model into a Map again', () async {
      //arrange
      final expectedJson =
          jsonDecode(fixtureReader(filename: 'feeling-raw.json'))
              as Map<String, dynamic>;
      //act
      final result = tFeelingModel.toJson();
      //assert
      expect(result, expectedJson);
    });
  });
}
