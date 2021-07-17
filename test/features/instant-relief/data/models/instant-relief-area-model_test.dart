// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/models/instant-relief-area-model.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/entities/instant-relief-area.dart';
import '../../../../fixtures/fixture-reader.dart';

void main() {
  final List<InstantReliefArea> tInstantReliefAreaModel =
      <InstantReliefAreaModel>[
    InstantReliefAreaModel(
      id: 1,
      title: "title",
      subtitle: "subtitle",
      instantReliefName: "instantReliefName",
      description: "description",
      icon: ImageModel.fromDomain(
        ImageEntity(
            type: 'URL', url: 'https://images.tatsam.in/Logo+512+x+512.png'),
      ),
    )
  ];
  group('Model InstantReliefAreaModel ', () {
    test('should be an extendor of Feeling', () async {
      //assert
      expect(tInstantReliefAreaModel.first, isA<InstantReliefArea>());
    });
    test('fromJson should transform raw-response into InstantReliefAreaModel',
            () async {
          //arrange
          final jsonMap =
          jsonDecode(fixtureReader(filename: 'raw-instant-relief-area.json'))
          as List;
          //act
          final result = jsonMap
              .map((area) =>
              InstantReliefAreaModel.fromJson(area as Map<String, dynamic>))
              .toList();
          //assert
          expect(result.toString(), tInstantReliefAreaModel.toString());
        });
    test('toJson should transform the model into a Map again', () async {
      //arrange
      // final expectedJson =
      // jsonDecode(fixtureReader(filename: 'single-instant-relief-area.json'))
      // as List<String, dynamic>?;
      //act
      final result = tInstantReliefAreaModel
          .map((area) => (area as InstantReliefAreaModel).toJson())
          .toList();
      //assert
      expect(result, jsonDecode(fixtureReader(filename: 'single-instant-relief-area.json')));
    });
  });
}
