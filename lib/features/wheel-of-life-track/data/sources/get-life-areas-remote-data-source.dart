// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../models/life-area-model.dart';

abstract class GetLifeAreasRemoteDataSource {
  Future<List<LifeAreaModel>> getAreas();
}

class GetLifeAreasRemoteDataSourceImpl implements GetLifeAreasRemoteDataSource {
  final http.Client client;
  final Box sessionClient;

  GetLifeAreasRemoteDataSourceImpl({
    @required this.client,
    @required this.sessionClient,
  });
  @override
  Future<List<LifeAreaModel>> getAreas() async {
    final header = await SessionManager.getHeader();
    final response = await client.get(
      Uri.parse(APIRoute.getWolAreas),
      headers: header,
    );
    SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map(
            (rawAreaJson) => LifeAreaModel.fromJson(
              rawAreaJson as Map<String, dynamic>,
            ),
          )
          .toList();
    } else {
      throw ServerException();
    }
  }
}
