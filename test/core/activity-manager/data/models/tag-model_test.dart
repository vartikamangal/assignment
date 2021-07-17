import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/tag.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/tag-model.dart';
import 'package:tatsam_app_experimental/features/view-all-content/data/models/data-model.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/entity.dart';
import '../../../../fixtures/fixture-reader.dart';

void main() {
  final Tags = Tag(
      name: 'LOSING_TEMPER',
      parentName: '',
      displayName: 'Losing Temper',
      tagCategory: "INSTANT_RELIEF");

  final tTagModel = TagModel.fromDomain(Tag(
      name: 'LOSING_TEMPER',
      parentName: '',
      displayName: 'Losing Temper',
      tagCategory: "INSTANT_RELIEF"));


  test('from domain to take entity and covert in TagModel', () async {
    //act
    final result = TagModel.fromDomain(Tags);
    //expect
    expect(result, isA<TagModel>());
  });

  test('from json should return valid tagModel', () async {
    //arrange
    final jsonMap = jsonDecode(fixtureReader(filename: 'raw-tag-model.json'))
    as List<dynamic>;
    //act
    final result = TagModel.fromJson(jsonMap.first as Map<String, dynamic>);

    //expect
    expect(result.toString(), tTagModel.toString());
  });

  test('To json of TagModel should return a json TagModel', () async {
    //arrange
    final jsonMap =
        jsonDecode(fixtureReader(filename: 'raw-tag-model.json')) as List;
    //act
    final j = tTagModel.toJson();
    //expect
    expect(jsonMap.first, j);
  });
  test('To domain should return tag', () async {
    //act
    final result = tTagModel.toDomain();
    //expect
    expect(result, isA<Tag>());
  });
}
