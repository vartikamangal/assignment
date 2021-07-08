import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/auth/data/models/oauth-data-model.dart';
import 'package:tatsam_app_experimental/core/auth/domain/entities/oauth-data.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tAuthDataModel = OAuthDataModel(
      idToken: 'idToken',
      accessToken: 'accessToken',
      refreshToken: 'refreshToken');

  group('Model OAuthDataModel', () {
    test('should be a extended version of AuthData', () async {
      expect(tAuthDataModel, isA<OAuthData>());
    });

    test('fromJson should transform raw-response into AuthDataModel', () async {
      //arrange
      final jsonMap =
          jsonDecode(fixtureReader(filename: 'auth-data-model.json'))
              as Map<String, dynamic>;
      //act
      final result = OAuthDataModel.fromJson(jsonMap);
      //assert
      expect(result, tAuthDataModel);
    });

    test('toJson should return a properly parsed Map from the model', () async {
      //act
      final result = tAuthDataModel.toJson();
      //assert
      expect(
          result, jsonDecode(fixtureReader(filename: 'auth-data-model.json')));
    });
  });
}
