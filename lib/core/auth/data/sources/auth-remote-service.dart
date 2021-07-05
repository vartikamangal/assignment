import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tatsam_app_experimental/core/jwt/jwt-operation-helper.dart';

import '../../../data-source/api-client.dart';
import '../../../data-source/throw-exception-if-response-error.dart';
import '../../../persistence-consts.dart';
import '../../../routes/api-routes/api-routes.dart';
import '../../../secrets.dart';
import '../../presentation/screens/auth-screen-test.dart';
import '../models/oauth-data-model.dart';
import '../models/user-data-model.dart';

abstract class AuthRemoteService {
  Future<OAuthDataModel> oauthLogin();
  Future<OAuthDataModel> oauthSignup();
  Future<Unit> requestLogout();
  Future<OAuthDataModel> requestNewToken();
  Future<bool> checkIfAuthenticated();
  Future<UserDataModel> getUserDetails();
}

class AuthRemoteServiceImpl implements AuthRemoteService {
  final FlutterSecureStorage secureStorage;
  final FlutterAppAuth flutterAppAuth;
  final ApiClient apiClient;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  AuthRemoteServiceImpl({
    required this.secureStorage,
    required this.flutterAppAuth,
    required this.apiClient,
    required this.throwExceptionIfResponseError,
  });

  /// If this returns false means user isn't authenticated and vice-versa
  @override
  Future<bool> checkIfAuthenticated() async {
    try {
      final refreshToken =
          await secureStorage.read(key: PersistenceConst.ACCESS_TOKEN);
      if (refreshToken == null) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<OAuthDataModel> oauthLogin() async {
    try {
      final List<String> _scopes = [
        'openid',
        'email',
        'offline_access',
        'api',
      ];
      final Map<String, String> _params = {
        'audience': Secrets.AUTH0_AUDIENCE,
      };
      final AuthorizationTokenResponse? tokenResponse =
          await flutterAppAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          Secrets.AUTH0_CLIENT_ID, Secrets.AUTH0_REDIRECT_URI,
          issuer: Secrets.AUTH0_ISSUER,
          scopes: _scopes,
          // If passing aud then no refresh token will come
          additionalParameters: _params,
          promptValues: ['login'],
        ),
      );
      final OAuthData = OAuthDataModel.fromAuthTokenResponse(tokenResponse);
      await _persistAccessToken(accessToken: OAuthData.accessToken);
      // Make a method for persisting the user-data
      final parsedUserdata = JWTOperationHelper.parseJwt(OAuthData.idToken!);
      final userDataModel = UserDataModel.fromJson(parsedUserdata);
      await _persistUserdata(
        userData: userDataModel,
      );
      await _loginRemoteApiHelper(user_id: userDataModel.sub);
      return OAuthData;
    } on PlatformException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<OAuthDataModel> oauthSignup() async {
    try {
      final List<String> _scopes = [
        'openid',
        'email',
        'offline_access',
        'api',
      ];
      final Map<String, String> _params = {
        'audience': Secrets.AUTH0_AUDIENCE,
        'screen_hint': 'signup',
      };
      final AuthorizationTokenResponse? tokenResponse =
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
      final OAuthData = OAuthDataModel.fromAuthTokenResponse(tokenResponse);
      await _persistAccessToken(accessToken: OAuthData.accessToken);
      // Make a method for persisting the user-data
      final parsedUserdata = JWTOperationHelper.parseJwt(OAuthData.idToken!);
      final userDataModel = UserDataModel.fromJson(parsedUserdata);
      await _persistUserdata(
        userData: userDataModel,
      );
      await _registrationRemoteApiHelper(user_id: userDataModel.sub);
      return OAuthData;
    } on PlatformException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Unit> requestLogout() async {
    try {
      await secureStorage.delete(key: PersistenceConst.ACCESS_TOKEN);
      return unit;
    } on PlatformException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // Will be called when NewLogin is true
  @override
  Future<OAuthDataModel> requestNewToken() async {
    try {
      final authDataUnparsed = await (secureStorage.read(
        key: PersistenceConst.ACCESS_TOKEN,
      ) as Future<String>);
      final authDataParsed = OAuthDataModel.fromJson(
        jsonDecode(authDataUnparsed) as Map<String, dynamic>,
      );
      final tokenResponse = await (appAuth.token(
        TokenRequest(
          Secrets.AUTH0_CLIENT_ID,
          Secrets.AUTH0_REDIRECT_URI,
          issuer: Secrets.AUTH0_ISSUER,
          additionalParameters: {
            'audience': Secrets.AUTH0_AUDIENCE,
          },
          refreshToken: authDataParsed.refreshToken,
        ),
      ) as Future<TokenResponse>);
      final OAuthData = OAuthDataModel.fromTokenResponse(tokenResponse);
      await _persistAccessToken(accessToken: OAuthData.accessToken);
      return OAuthData;
    } on PlatformException catch (e) {
      log(e.toString());
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
    required String? user_id,
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
    required String? user_id,
  }) async {
    final response = await apiClient.post(
      uri: APIRoute.register,
      body: jsonEncode(user_id),
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    log('user registsered successfully!');
  }

  Future<void> _persistAccessToken({
    required String? accessToken,
  }) async {
    await secureStorage.write(
      key: PersistenceConst.ACCESS_TOKEN,
      value: accessToken,
    );
  }

  Future<void> _persistUserdata({
    required UserDataModel userData,
  }) async {
    await secureStorage.write(
      key: PersistenceConst.USER_DATA,
      value: jsonEncode(
        userData.toJson(),
      ),
    );
  }
}
