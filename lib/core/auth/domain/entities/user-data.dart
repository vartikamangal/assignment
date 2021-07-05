import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class UserData extends Equatable {
  final String? givenName;
  final String? familyName;
  final String? nickname;
  final String? name;
  final String? picture;
  final String? locale;
  final String? updatedAt;
  final String? email;
  final bool? emailVerified;
  final String? iss;
  final String? sub;
  final String? aud;
  final int? iat;
  final int? exp;
  final String? nonce;

  const UserData({
    required this.givenName,
    required this.familyName,
    required this.nickname,
    required this.name,
    required this.picture,
    required this.locale,
    required this.updatedAt,
    required this.email,
    required this.emailVerified,
    required this.iss,
    required this.sub,
    required this.aud,
    required this.iat,
    required this.exp,
    required this.nonce,
  });

  @override
  List<Object?> get props {
    return [
      givenName,
      familyName,
      nickname,
      name,
      picture,
      locale,
      updatedAt,
      email,
      emailVerified,
      iss,
      sub,
      aud,
      iat,
      exp,
      nonce,
    ];
  }
}
