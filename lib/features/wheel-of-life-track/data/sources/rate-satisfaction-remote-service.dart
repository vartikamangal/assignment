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
import '../../domain/entities/rated-satisfaction-success.dart';
import '../models/satisfaction-ratings-model.dart';

abstract class RateSatisfactionRemoteService {
  Future<SuccessRatedSatisfaction> rateSatisfaction({
    @required SatisfactionRatingsModel ratings,
  });
}

class RateSatisfactionRemoteServiceImpl
    implements RateSatisfactionRemoteService {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  RateSatisfactionRemoteServiceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<SuccessRatedSatisfaction> rateSatisfaction({
    @required SatisfactionRatingsModel ratings,
  }) async {
    final response = await client.post(
      uri: APIRoute.setUserSatisfaction,
      body: jsonEncode(ratings.toJson()),
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    return SuccessRatedSatisfaction();
  }
}
