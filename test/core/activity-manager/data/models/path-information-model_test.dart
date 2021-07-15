import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/path-information-guided.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/path-information-model.dart';
import '../../../../fixtures/fixture-reader.dart';

void main() {
  final List<PathInformationModel> tPathInformation = <PathInformationModel>[
    // PathInformationModel(
    //     id: 3442,
    //     description: "Curated Path for stress management",
    //     title: "Stress management",
    //     subtitle: "This will help you manage stress better",
    //     helpContent: "Just putting some help content for future use",
    //     lengthOfPlan: 23)
  ];

  // group('Model PathInformationModel ', () {
  //   test('should be an extendor of PathInformationModel', () async {
  //     //assert
  //     expect(tPathInformation.first, isA<PathInformation>());
  //   });
  //   test('fromJson should transform raw-response into PathInformationModel',
  //       () async {
  //     //arrange
  //     final jsonMap =
  //         jsonDecode(fixtureReader(filename: 'path-information.json')) as List;
  //     //act
  //     final result = jsonMap
  //         .map((area) =>
  //             PathInformationModel.fromJson(area as Map<String, dynamic>))
  //         .toList();
  //     //assert
  //     expect(result, tPathInformation);
  //   });
  //   test('toJson should transform the model into a Map again', () async {
  //     //arrange
  //     final expectedJson =
  //         jsonDecode(fixtureReader(filename: 'path-information.json')) as List?;
  //     //act
  //     final result = tPathInformation
  //         .map((area) => (area as PathInformationModel).toJson())
  //         .toList();
  //     //assert
  //     expect(result, expectedJson);
  //   });
  // });
}
