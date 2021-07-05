import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/tag.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/tag-model.dart';
import '../../../../fixtures/fixture-reader.dart';

void main(){
  const List<Tag> tTags=<TagModel>[
    TagModel(
      name: "LOSING_TEMPER",
      tagCategory:"INSTANT_RELIEF",
      displayName: "Losing Temper",
      parentName: null,
    )
  ];

  group('Model TagModel ', () {
    test('should be an extendor of TagModel', () async {
      //assert
      expect(tTags.first, isA<Tag>());
    });
      test('fromJson should transform raw-response into TagModel',
              () async {
            //arrange
            final jsonMap =
            jsonDecode(fixtureReader(filename: 'raw-tag-model.json'))
            as List;
            //act
            final result = jsonMap
                .map((area) =>
                TagModel.fromJson(area as Map<String, dynamic>))
                .toList();
            //assert
            expect(result, tTags);
          });
      test('toJson should transform the model into a Map again', () async {
        //arrange
        final expectedJson =
        jsonDecode(fixtureReader(filename: 'raw-tag-model.json'))
        as List?;
        //act
        final result = tTags
            .map((area) => (area as TagModel).toJson())
            .toList();
        //assert
        expect(result, expectedJson);
      });
  });
}