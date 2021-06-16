import 'package:flutter/foundation.dart';
import '../../domain/entities/request-data.dart';

class RequestDataModel extends RequestData {
  const RequestDataModel({
    @required String idToken,
    @required String accessToken,
    @required String refreshToken,
  }) : super(
          idToken: idToken,
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

  factory RequestDataModel.fromJson(Map<String, dynamic> jsonMap) {
    return RequestDataModel(
      idToken: jsonMap['idToken'] as String,
      accessToken: jsonMap['accessToken'] as String,
      refreshToken: jsonMap['refreshToken'] as String,
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
