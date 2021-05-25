import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/models/emergency-number-model.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/entities/emergency-number.dart';

import '../../../../fixtures/fixture-reader.dart';

void main(){
  const tNumber="9545865596";
  const tEmergencyNumberModel=EmergencyNumberModel(number: tNumber);

  group('Model EmergencyNumberModel ', () {
    test('should be an extendor of EmergencyNumber', () async {
      //assert
      expect(tEmergencyNumberModel, isA<EmergencyNumber>());
    });
    test('fromJson should transform raw-response into EmergencyNumberModel', () async {
      //arrange
      final jsonMap = jsonDecode(fixtureReader(filename: 'raw-emergency-number.json'))
      as Map<String, dynamic>;
      //act
      final result = EmergencyNumberModel.fromJson(jsonMap);
      //assert
      expect(result, tEmergencyNumberModel);
    });
    test('toJson should transform the model into a Map again', () async {
      //arrange
      final expectedJson =
      jsonDecode(fixtureReader(filename: 'raw-emergency-number.json'))
      as Map<String, dynamic>;
      //act
      final result = tEmergencyNumberModel.toJson();
      //assert
      expect(result, expectedJson);
    });
  });
}