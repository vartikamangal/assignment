// Flutter imports:
import 'dart:developer';

import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

// Project imports:
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../domain/entities/success-create-traveller.dart';

abstract class CreateTravellerRemoteService {
  Future<SuccessCreatedTraveller> createTraveller();
}

class CreateTravellerRemoteServiceImpl implements CreateTravellerRemoteService {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  CreateTravellerRemoteServiceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<SuccessCreatedTraveller> createTraveller() async {
    final response = await client.get(
      uri: APIRoute.createNewTraveller,
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    return const SuccessCreatedTraveller();
  }
}
