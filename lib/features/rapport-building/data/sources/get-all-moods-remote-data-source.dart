// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../models/mood-model.dart';

abstract class GetAllMoodsRemoteDataSource {
  Future<List<MoodModel>> getMoods();
}

class GetAllMoodsRemoteDataSourceImpl implements GetAllMoodsRemoteDataSource {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  GetAllMoodsRemoteDataSourceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<List<MoodModel>> getMoods() async {
    final response = await client.get(
      uri: APIRoute.getMoods,
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    return (jsonDecode(response.body) as List)
        .map((moodRaw) => MoodModel.fromJson(moodRaw as Map<String, dynamic>))
        .toList();
  }
}
