// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/models/journey-model.dart';
import '../../../../fixtures/fixture-reader.dart';

void main(){
  final tJourneyModel = JourneyModel(
      id: 1,
      title: "Small Wins Path",
      subtitle: "Weekly focus areas. Choose your own experiences.",
      description: "Only one area of focus per week, Daily small wins at your own pace",
      icon:null,
      pathName: "SMALL_WINS");

  group('MODEL JourneyModel ', () {
    test('should be a extended version of Journey', () async {
      //assert
      expect(tJourneyModel, isA<JourneyModel>());
    });
  });
}
