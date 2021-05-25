import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/models/instant-relief-area-model.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/entities/instant-relief-area.dart';

import '../../../../fixtures/fixture-reader.dart';

void main(){
  const tInstantReliefArea=InstantReliefArea(
      id: 1,
      title: "title",
      subtitle: "subtitle",
      instantReliefName: "instantReliefName",
      description: "description",
      icon: ImageProp(urlShort: "",
      urlLarge: "",
      urlMedium: ""));
  const tInstantReliefAreaModel=InstantReliefAreaModel(
      id: 1,
      title: "title",
      subtitle: "subtitle",
      instantReliefName: "instantReliefName",
      description: "description",
      icon: ImageProp(urlShort: "",
          urlLarge: "",
          urlMedium: ""));
  group('Model InstantReliefAreaModel ', () {
    test('should be an extendor of Feeling', () async {
      //assert
      expect(tInstantReliefAreaModel, isA<InstantReliefArea>());
    });
    test('fromJson should transform raw-response into InstantReliefAreaModel', () async {
      //arrange
      final jsonMap = jsonDecode(fixtureReader(filename: 'raw-instant-relief-area.json'))
      as Map<String, dynamic>;
      //act
      final result = InstantReliefAreaModel.fromJson(jsonMap);
      //assert
      expect(result, tInstantReliefAreaModel);
    });
    test('toJson should transform the model into a Map again', () async {
      //arrange
      final expectedJson =
      jsonDecode(fixtureReader(filename: 'raw-instant-relief-area.json'))
      as Map<String, dynamic>;
      //act
      final result = tInstantReliefAreaModel.toJson();
      //assert
      expect(result, expectedJson);
    });
  });
}