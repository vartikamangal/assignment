import 'dart:convert';

import 'package:hive/hive.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/persistence-consts.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../models/instant-relief-area-model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class GetInstantReliefAreasRemoteDataSource {
  Future<List<InstantReliefAreaModel>> getReliefAreas();
}

class GetInstantReliefAreasRemoteDataSourceImpl
    implements GetInstantReliefAreasRemoteDataSource {
  final http.Client client;

  GetInstantReliefAreasRemoteDataSourceImpl({
    @required this.client,
  });
  @override
  Future<List<InstantReliefAreaModel>> getReliefAreas() async {
    final headers = await SessionManager.getHeader();
    final response = await client.get(
      Uri.parse(APIRoute.getInstantReliefAreas),
      headers: headers,
    );
    SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      final instantReliefAreasRaw = jsonDecode(response.body) as List;
      return instantReliefAreasRaw
          .map(
            (instantReliefArea) => InstantReliefAreaModel.fromJson(
                instantReliefArea as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw ServerException();
    }
  }
}
