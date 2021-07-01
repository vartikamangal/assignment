import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/common-input-feedback-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/entities/common-input-feedback.dart';
import '../../../../fixtures/fixture-reader.dart';

void main(){
  const tInputFeedbackModel=CommonInputFeedbackModel(subjectId: "",
  activityType: "",
  textFeedback: "",
  voiceNote: "",
  timeOfCreation: "");

  group('MODEL CommonInputFeedbackModel ', () {
    test('should be a extended version of CommonInputFeedbackModel', () async {
      //assert
      expect(tInputFeedbackModel, isA<CommonInputFeedback>());
    });
    test(' .fromJson should return a valid CommonInputFeedback', () async {
      //arrange
      final jsonMap = jsonDecode(fixtureReader(filename: 'raw-common-input-feedback-model.json'))
      as List<dynamic>;
      //act
      final result = CommonInputFeedbackModel.fromJson(jsonMap.first as Map<String, dynamic>);
      //assert
      expect(result, tInputFeedbackModel);
    });
    test('toJson should return a properly parsed Map from the model', () async {
      //act
      final result = tInputFeedbackModel.toJson();
      //assert
      expect(result, jsonDecode(fixtureReader(filename: 'single-common-input-feedback-model.json')));
    });
  });
}