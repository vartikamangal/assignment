import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class OAuthData extends Equatable {
  final String idToken;
  final String accessToken;
  final String refreshToken;

  const OAuthData({
    @required this.idToken,
    @required this.accessToken,
    @required this.refreshToken,
  });

  @override
  List<Object> get props => [idToken, accessToken, refreshToken];

  @override
  bool get stringify => true;
}
