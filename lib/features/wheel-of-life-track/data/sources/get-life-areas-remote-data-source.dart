// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../models/life-area-model.dart';

abstract class GetLifeAreasRemoteDataSource {
  Future<List<LifeAreaModel>> getAreas();
}

class GetLifeAreasRemoteDataSourceImpl implements GetLifeAreasRemoteDataSource {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  GetLifeAreasRemoteDataSourceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<List<LifeAreaModel>> getAreas() async {
    final response = await client.get(
      uri: APIRoute.getWolAreas,
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    return (jsonDecode(response.body) as List)
        .map(
          (rawAreaJson) => LifeAreaModel.fromJson(
            rawAreaJson as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}
