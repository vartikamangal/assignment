// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

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
  final http.Client client;
  final Box sessionClient;

  RateSatisfactionRemoteServiceImpl({
    @required this.client,
    @required this.sessionClient,
  });
  @override
  Future<SuccessRatedSatisfaction> rateSatisfaction({
    @required SatisfactionRatingsModel ratings,
  }) async {
    final header = await SessionManager.getHeader();
    final response = await client.post(
      Uri.parse(APIRoute.setUserSatisfaction),
      headers: header as Map<String, String>,
      body: jsonEncode(ratings.toJson()),
    );
    await SessionManager.setHeader(
      header: response.headers,
    );
    // Persists the fresh header before proceeding
    if (response.statusCode == 200) {
      return SuccessRatedSatisfaction();
    } else {
      throw ServerException();
    }
  }
}
