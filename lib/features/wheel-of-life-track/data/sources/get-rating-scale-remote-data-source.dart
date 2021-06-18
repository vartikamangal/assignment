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
import '../models/rating-scale-model.dart';

abstract class GetRatingScaleRemoteDataSource {
  Future<RatingScaleModel> getRatingScale();
}

class GetRatingScaleRemoteDataSourceImpl
    implements GetRatingScaleRemoteDataSource {
  final http.Client client;

  GetRatingScaleRemoteDataSourceImpl({
    @required this.client,
  });
  @override
  Future<RatingScaleModel> getRatingScale() async {
    final header = await SessionManager.getHeader();

    final response = await client.get(
      Uri.parse(APIRoute.getRatingScale),
      headers: header as Map<String, String>,
    );
    print(response.headers);
    await SessionManager.setHeader(header: response.headers);
    if (response.statusCode == 200) {
      return RatingScaleModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw ServerException();
    }
  }
}
