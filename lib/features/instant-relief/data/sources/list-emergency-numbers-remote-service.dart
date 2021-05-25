import 'dart:convert';

import 'package:hive/hive.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/persistence-consts.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../models/emergency-number-model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class ListEmergencyNumberRemoteDataSource {
  Future<List<EmergencyNumberModel>> fetchEmergencyNumbers();
}

class ListEmergencyNumberRemoteDataSourceImpl
    implements ListEmergencyNumberRemoteDataSource {
  final http.Client client;

  ListEmergencyNumberRemoteDataSourceImpl({
    @required this.client,
  });
  @override
  Future<List<EmergencyNumberModel>> fetchEmergencyNumbers() async {
    final headers = await SessionManager.getHeader();
    final response = await client.get(
      Uri.parse(APIRoute.listEmergencyNumbers),
      headers: headers,
    );
    SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      final emergencyContactsRaw = jsonDecode(response.body) as List;
      return emergencyContactsRaw
          .map(
            (emergencyContact) => EmergencyNumberModel.fromJson(
                emergencyContact as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw ServerException();
    }
  }
}
