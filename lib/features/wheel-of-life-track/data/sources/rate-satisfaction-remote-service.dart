import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/persistence-consts.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../models/satisfaction-ratings-model.dart';
import '../../domain/entities/rated-satisfaction-success.dart';
import 'package:http/http.dart' as http;

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
