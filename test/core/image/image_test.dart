import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';

import '../../fixtures/fixture-reader.dart';

void main() {
  const tImagePropModel =
      ImagePropModel(iconLocator: 'iconLocator', iconType: 'iconType');

  group('Model ImagePropModel ', () {
    test('should be an extendor of ImageProp', () async {
      //assert
      expect(tImagePropModel, isA<ImageProp>());
    });
    test('fromJson should transform raw-response into ImagePropModel',
        () async {
      //arrange
      final jsonMap = jsonDecode(fixtureReader(filename: 'raw-image.json'))
          as Map<String, dynamic>;
      //act
      final result = ImagePropModel.fromJson(jsonMap);
      //assert
      expect(result, tImagePropModel);
    });
  });
}
