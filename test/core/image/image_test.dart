import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';

import '../../fixtures/fixture-reader.dart';

void main() {
  final ImageEntity tImage = ImageEntity(type: 'type', url: 'url');

  group('Model ImageEntity ', () {
    test('should be an extendor of ImageEntity', () async {
      //assert
      expect(tImage, isA<ImageEntity>());
    });
    // test('fromJson should transform raw-response into ImagePropModel',
    //     () async {
    //   //arrange
    //   final jsonMap = jsonDecode(fixtureReader(filename: 'raw-image.json'))
    //       as Map<String, dynamic>;
    //   //act
    //   final result = ImageModel.fromJson(jsonMap);
    //   //assert
    //   expect(result, tImage);
    // });
  });
}