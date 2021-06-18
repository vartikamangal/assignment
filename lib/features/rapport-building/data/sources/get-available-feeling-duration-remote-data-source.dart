// Dart imports:
import 'dart:convert';

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
import '../models/feeling-duration-model.dart';

abstract class GetAvailableFeelingDurationRemoteDataSource {
  Future<List<FeelingDurationModel>> getAvailableDurations();
}

class GetAvailableFeelingDurationRemoteDataSourceImpl
    implements GetAvailableFeelingDurationRemoteDataSource {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  GetAvailableFeelingDurationRemoteDataSourceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<List<FeelingDurationModel>> getAvailableDurations() async {
    final response = await client.get(
      uri: APIRoute.getDurationOptions,
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    final rawDurationList = jsonDecode(response.body) as List;
    return rawDurationList
        .map(
          (rawDuration) => FeelingDurationModel.fromJson(
              rawDuration as Map<String, dynamic>),
        )
        .toList();
  }
}
