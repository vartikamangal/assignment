import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood.dart';
import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tMoodModel = MoodModel(
    id: 1,
    moodName: 'VERY_BAD',
    moodDescription: 'Very sad',
    icon: ImageProp(
      urlLarge: '',
      urlMedium: '',
      urlShort: '',
    ),
  );

  group('MODEL MoodModel ', () {
    test('should be a extended version of Mood', () async {
      //assert
      expect(tMoodModel, isA<Mood>());
    });
    test(' .fromJson should return a valid Mood', () async {
      //arrange
      final jsonMap = jsonDecode(fixtureReader(filename: 'raw-moods.json'))
          as List<dynamic>;
      //act
      final result = MoodModel.fromJson(jsonMap.first as Map<String, dynamic>);
      //assert
      expect(result, tMoodModel);
    });
    test('toJson should return a properly parsed Map from the model', () async {
      //act
      final result = tMoodModel.toJson();
      //assert
      expect(result, jsonDecode(fixtureReader(filename: 'single-journey.json')));
    });
  });
}
