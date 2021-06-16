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
import '../../../../core/persistence-consts.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../../domain/entities/success-prioritize.dart';
import '../models/life-area-model-for-prioritization.dart';

abstract class PrioritizeRemoteService {
  Future<SuccessPrioritize> prioritize({
    @required LifeAreaModelForPrioritization lifeAreas,
  });
}

class PrioritizeRemoteServiceImpl implements PrioritizeRemoteService {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  PrioritizeRemoteServiceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<SuccessPrioritize> prioritize({
    @required LifeAreaModelForPrioritization lifeAreas,
  }) async {
    final response = await client.post(
      uri: APIRoute.prioritizeAreas,
      body: jsonEncode(lifeAreas.toJson()),
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    return SuccessPrioritize();
  }
}
