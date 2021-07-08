import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/auth/data/models/user-data-model.dart';
import 'package:tatsam_app_experimental/core/auth/domain/entities/user-data.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tUserDataModel = UserDataModel(
      givenName: 'givenName',
      familyName: 'familyName',
      nickname: 'nickname',
      name: 'name',
      picture: 'picture',
      locale: 'locale',
      updatedAt: 'updatedAt',
      email: 'email',
      emailVerified: null,
      iss: 'iss',
      sub: 'sub',
      aud: 'aud',
      iat: 1,
      exp: 1,
      nonce: 'nonce');

  group('Model UserDataModel', () {
    test('should be a extended version of UserData', () async {
      expect(tUserDataModel, isA<UserData>());
    });

    test('fromJson should transform raw-response into UserDataModel', () async {
      //arrange
      final jsonMap =
          jsonDecode(fixtureReader(filename: 'user-data-model.json'))
              as Map<String, dynamic>;
      //act
      final result = UserDataModel.fromJson(jsonMap);
      //assert
      expect(result, tUserDataModel);
    });

    test('toJson should return a properly parsed Map from the model', () async {
      //act
      final result = tUserDataModel.toJson();
      //assert
      expect(
          result, jsonDecode(fixtureReader(filename: 'user-data-model.json')));
    });
  });
}
