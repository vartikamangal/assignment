import 'package:flutter_appauth/flutter_appauth.dart';

import '../../domain/entities/oauth-data.dart';

class OAuthDataModel extends OAuthData {
  const OAuthDataModel({
    required String? idToken,
    required String? accessToken,
    required String? refreshToken,
  }) : super(
          idToken: idToken,
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

  factory OAuthDataModel.fromJson(Map<String, dynamic> jsonMap) {
    return OAuthDataModel(
      idToken: jsonMap['idToken'] as String?,
      accessToken: jsonMap['accessToken'] as String?,
      refreshToken: jsonMap['refreshToken'] as String?,
    );
  }

  factory OAuthDataModel.fromAuthTokenResponse(
      AuthorizationTokenResponse? tokenResponse) {
    return OAuthDataModel(
      idToken: tokenResponse!.idToken,
      accessToken: tokenResponse.accessToken,
      refreshToken: tokenResponse.refreshToken,
    );
  }

  factory OAuthDataModel.fromTokenResponse(TokenResponse tokenResponse) {
    return OAuthDataModel(
      idToken: tokenResponse.idToken,
      accessToken: tokenResponse.accessToken,
      refreshToken: tokenResponse.refreshToken,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idToken': idToken,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
