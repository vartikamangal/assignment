import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

import '../../../error/exceptions.dart';
import '../../../persistence-consts.dart';
import '../../../routes/api-routes/api-routes.dart';
import '../../../secrets.dart';
import '../../../session-manager/session-manager.dart';
import '../../presentation/screens/auth-screen-test.dart';
import '../models/request-data-model.dart';
import '../models/user-data-model.dart';

abstract class AuthRemoteService {
  Future<RequestDataModel> requestLogin({
    @required bool isNewLogin,
  });
  Future<Unit> requestLogout();
  Future<RequestDataModel> requestNewToken();
  Future<bool> checkIfAlreadyLoggedIn();
  Future<UserDataModel> getUserDetails();
}

class AuthRemoteServiceImpl implements AuthRemoteService {
  final FlutterSecureStorage secureStorage;
  final FlutterAppAuth flutterAppAuth;
  final ApiClient apiClient;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  AuthRemoteServiceImpl({
    @required this.secureStorage,
    @required this.flutterAppAuth,
    @required this.apiClient,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<bool> checkIfAlreadyLoggedIn() async {
    try {
      final refreshToken = await secureStorage.read(
        key: PersistenceConst.ACCESS_TOKEN,
      );
      if (refreshToken == null) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (e) {
      log(
        e.toString(),
      );
      rethrow;
    }
  }

  @override
  Future<RequestDataModel> requestLogin({
    bool isNewLogin,
  }) async {
    try {
      final List<String> _scopes = [
        'openid',
        'email',
        'offline_access',
        'api',
      ];
      final Map<String, String> _params = isNewLogin
          ? {
              'audience': Secrets.AUTH0_AUDIENCE,
              'screen_hint': 'signup',
            }
          : {
              'audience': Secrets.AUTH0_AUDIENCE,
            };
      final AuthorizationTokenResponse result =
          await flutterAppAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          Secrets.AUTH0_CLIENT_ID,
          Secrets.AUTH0_REDIRECT_URI,
          issuer: Secrets.AUTH0_ISSUER,

          scopes: _scopes,
          // If passing aud then no refresh token will come
          additionalParameters: _params,
          promptValues: ['login'],
        ),
      );
      final requestData = RequestDataModel(
        idToken: result.idToken,
        accessToken: result.accessToken,
        refreshToken: result.refreshToken,
      );
      await _saveRefreshTokenToSecureStorage(
        requestData: requestData,
      );
      // Make a method for persisting the user-data
      final parsedUserdata = _parseJwt(result.idToken);
      final userDataModel = UserDataModel.fromJson(parsedUserdata);
      await _persistUserdata(
        userData: userDataModel,
      );
      //* After login is completed, saved the parsed user_id_token to the tatsam_backend
      //* will store the sub-part of userdatamodel on tatsam-backend
      //* if isNew login --> means registration, else login
      isNewLogin
          ? await _registrationRemoteApiHelper(user_id: userDataModel.sub)
          : await _loginRemoteApiHelper(user_id: userDataModel.sub);
      return requestData;
    } on PlatformException catch (e) {
      log(
        e.toString(),
      );
      rethrow;
    }
  }

  @override
  Future<Unit> requestLogout() async {
    try {
      await secureStorage.delete(key: PersistenceConst.ACCESS_TOKEN);
      return unit;
    } on PlatformException catch (e) {
      log(
        e.toString(),
      );
      rethrow;
    }
  }

  // Will be called when NewLogin is true
  @override
  Future<RequestDataModel> requestNewToken() async {
    try {
      final requestDataUnparsed = await secureStorage.read(
        key: PersistenceConst.ACCESS_TOKEN,
      );
      final requestDataParsed = RequestDataModel.fromJson(
        jsonDecode(requestDataUnparsed) as Map<String, dynamic>,
      );
      final result = await appAuth.token(
        TokenRequest(
          Secrets.AUTH0_CLIENT_ID,
          Secrets.AUTH0_REDIRECT_URI,
          issuer: Secrets.AUTH0_ISSUER,
          additionalParameters: {
            'audience': Secrets.AUTH0_AUDIENCE,
          },
          refreshToken: requestDataParsed.refreshToken,
        ),
      );
      final newRequestData = RequestDataModel(
        idToken: result.idToken,
        accessToken: result.accessToken,
        refreshToken: result.refreshToken,
      );
      await _saveRefreshTokenToSecureStorage(
        requestData: newRequestData,
      );
      return newRequestData;
    } on PlatformException catch (e) {
      log(
        e.toString(),
      );
      rethrow;
    }
  }

  @override
  Future<UserDataModel> getUserDetails() {
    throw UnimplementedError();
  }

  /////////// HELPER METHODS //////////////

  /// Saves the user_id onto the tatsam_auth_api
  Future<void> _loginRemoteApiHelper({
    @required String user_id,
  }) async {
    final response = await apiClient.post(
      uri: APIRoute.login,
      body: jsonEncode(user_id),
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    log('user logged in successfully!');
  }

  /// Saves the user_id onto the tatsam_auth_api
  Future<void> _registrationRemoteApiHelper({
    @required String user_id,
  }) async {
    final response = await apiClient.post(
      uri: APIRoute.register,
      body: jsonEncode(user_id),
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    log('user registsered successfully!');
  }

  Future<void> _saveRefreshTokenToSecureStorage({
    @required RequestDataModel requestData,
  }) async {
    await secureStorage.write(
      key: PersistenceConst.ACCESS_TOKEN,
      value: requestData.accessToken,
    );
  }

  Map<String, dynamic> _parseJwt(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        throw Exception('invalid token');
      }

      final payload = _decodeBase64(parts[1]);
      final payloadMap = json.decode(payload);
      if (payloadMap is! Map<String, dynamic>) {
        throw Exception('invalid payload');
      }

      return payloadMap as Map<String, dynamic>;
    } on PlatformException catch (e) {
      log(
        e.toString(),
      );
      rethrow;
    }
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  Future<void> _persistUserdata({
    @required UserDataModel userData,
  }) async {
    await secureStorage.write(
      key: PersistenceConst.USER_DATA,
      value: jsonEncode(
        userData.toJson(),
      ),
    );
  }
}
