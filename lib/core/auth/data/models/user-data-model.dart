import '../../domain/entities/user-data.dart';

class UserDataModel extends UserData {
  const UserDataModel({
    required String? givenName,
    required String? familyName,
    required String? nickname,
    required String? name,
    required String? picture,
    required String? locale,
    required String? updatedAt,
    required String? email,
    required bool? emailVerified,
    required String? iss,
    required String? sub,
    required String? aud,
    required int? iat,
    required int? exp,
    required String? nonce,
  }) : super(
          sub: sub,
          email: email,
          nonce: nonce,
          nickname: nickname,
          familyName: familyName,
          updatedAt: updatedAt,
          iat: iat,
          emailVerified: emailVerified,
          exp: exp,
          iss: iss,
          name: name,
          givenName: givenName,
          locale: locale,
          aud: aud,
          picture: picture,
        );

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      givenName: json['given_name'] as String?,
      familyName: json['family_name'] as String?,
      nickname: json['nickname'] as String?,
      name: json['name'] as String?,
      picture: json['picture'] as String?,
      locale: json['locale'] as String?,
      updatedAt: json['updated_at'] as String?,
      email: json['email'] as String?,
      emailVerified: json['emailVerified'] as bool?,
      iss: json['iss'] as String?,
      sub: json['sub'] as String?,
      aud: json['aud'] as String?,
      iat: json['iat'] as int?,
      exp: json['exp'] as int?,
      nonce: json['nonce'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['given_name'] = givenName;
    data['family_name'] = familyName;
    data['nickname'] = nickname;
    data['name'] = name;
    data['picture'] = picture;
    data['locale'] = locale;
    data['updated_at'] = updatedAt;
    data['email'] = email;
    data['email_verified'] = emailVerified;
    data['iss'] = iss;
    data['sub'] = sub;
    data['aud'] = aud;
    data['iat'] = iat;
    data['exp'] = exp;
    data['nonce'] = nonce;
    return data;
  }
}
