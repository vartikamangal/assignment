// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/persistence-consts.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../models/emergency-number-model.dart';

abstract class ListEmergencyNumberRemoteDataSource {
  Future<List<EmergencyNumberModel>> fetchEmergencyNumbers();
}

class ListEmergencyNumberRemoteDataSourceImpl
    implements ListEmergencyNumberRemoteDataSource {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  ListEmergencyNumberRemoteDataSourceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<List<EmergencyNumberModel>> fetchEmergencyNumbers() async {
    final response = await client.get(
      uri: APIRoute.listEmergencyNumbers,
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    final emergencyContactsRaw = jsonDecode(response.body) as List;
    return emergencyContactsRaw
        .map(
          (emergencyContact) => EmergencyNumberModel.fromJson(
              emergencyContact as Map<String, dynamic>),
        )
        .toList();
  }
}
