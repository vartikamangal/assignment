// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/models/journey-model.dart';
import '../../../../fixtures/fixture-reader.dart';

void main(){
  const tJourneyModel = JourneyModel(
      id: 1,
      title: "Small Wins Path",
      subtitle: "Weekly focus areas. Choose your own experiences.",
      description: "Only one area of focus per week, Daily small wins at your own pace",
      icon:'',
      pathName: "SMALL_WINS");

  group('MODEL JourneyModel ', () {
    test('should be a extended version of Journey', () async {
      //assert
      expect(tJourneyModel, isA<JourneyModel>());
    });
    test(' .fromJson should return a valid Journey', () async {
      //arrange
      final jsonMap = jsonDecode(fixtureReader(filename: 'raw-journey.json'))
      as List<dynamic>;
      //act
      final result = JourneyModel.fromJson(jsonMap.first as Map<String, dynamic>);
      //assert
      expect(result, tJourneyModel);
    });
    test('toJson should return a properly parsed Map from the model', () async {
      //act
      final result = tJourneyModel.toJson();
      //assert
      expect(result, jsonDecode(fixtureReader(filename: 'single-journey.json')));
    });
  });
}
