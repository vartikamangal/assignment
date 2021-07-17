import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/path-information-model.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/path-information-guided.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  final tPathInformation = PathInformation(
      id: 3442,
      description: 'Curated Path for stress management',
      title: 'Stress management',
      subtitle: 'This will help you manage stress better',
      helpContent: 'Just putting some help content for future use',
      lengthOfPlan: 23);

  final tPathInformationModel = PathInformationModel.fromDomain(PathInformation(
      id: 3442,
      description: 'Curated Path for stress management',
      title: 'Stress management',
      subtitle: 'This will help you manage stress better',
      helpContent: 'Just putting some help content for future use',
      lengthOfPlan: 23));

  test('from domain to take entity and covert in PathInformationModel',
      () async {
    //act
    final result = PathInformationModel.fromDomain(tPathInformation);
    //expect
    expect(result, isA<PathInformationModel>());
  });

  test('from json should return valid PathInformationModel', () async {
    //arrange
    final jsonMap = jsonDecode(fixtureReader(filename: 'path-information.json'))
        as List<dynamic>;
    //act
    final result =
        PathInformationModel.fromJson(jsonMap.first as Map<String, dynamic>);

    //expect
    expect(result.toString(), tPathInformationModel.toString());
  });

  test(
      'To json of ActivityStatusModel should return a json PathInformationModel',
      () async {
    //arrange
    final jsonMap =
        jsonDecode(fixtureReader(filename: 'path-information.json')) as List;
    //act
    final j = tPathInformationModel.toJson();
    //expect
    expect(jsonMap.first, j);
  });
  test('To domain should return PathInformation', () async {
    //act
    final result = tPathInformationModel.toDomain();
    //expect
    expect(result, isA<PathInformation>());
  });
}
