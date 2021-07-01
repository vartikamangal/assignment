import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/app-page-status/data/models/app-route-model.dart';
import 'package:tatsam_app_experimental/core/app-page-status/data/repository/app-page-status-repository-impl.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/hub-status-model.dart';

import '../../../extensions/to-app-route.dart';

enum AbandonedPageStates {
  ONLY_NICKNAME,
  MOOD_ENTERED,
  UNTILL_PRIORIITIES,
  UNTILL_RATINGS,
  UNTILL_TARGETS,
  UNTILL_QUESTIONNAIRE,
  //TRAVELLER_CREATED,
  ONBOARDED,
  FALLBACK,
}

abstract class AppPageStatusLocalDataSource {
  Future<AppRouteModel> getLastAbandonedPage({
    @required HubStatusModel hubStatusModel,
  });
}

class AppPageStatusLocalDataSourceImpl implements AppPageStatusLocalDataSource {
  @override
  Future<AppRouteModel> getLastAbandonedPage({
    @required HubStatusModel hubStatusModel,
  }) async {
    try {
      final mostRecentPageState = hubStatusModel.recentlyAbandonedPage();
      switch (mostRecentPageState) {
        case AbandonedPageStates.ONLY_NICKNAME:
          return RouteName.rapportPages.makeAppRoute();
        case AbandonedPageStates.MOOD_ENTERED:
          return RouteName.rapportPages.makeAppRoute();
        case AbandonedPageStates.UNTILL_PRIORIITIES:
          return RouteName.hubScreen.makeAppRoute();
        case AbandonedPageStates.UNTILL_RATINGS:
          return RouteName.hubScreen.makeAppRoute();
        case AbandonedPageStates.UNTILL_TARGETS:
          return RouteName.hubScreen.makeAppRoute();
        case AbandonedPageStates.UNTILL_QUESTIONNAIRE:
          return RouteName.hubScreen.makeAppRoute();
        // case AbandonedPageStates.TRAVELLER_CREATED:
        //   return RouteName.whatPathChooseScreen.makeAppRoute();
        case AbandonedPageStates.ONBOARDED:
          return RouteName.onBoardingIncomplete.makeAppRoute();
        case AbandonedPageStates.FALLBACK:
          return appFallbackRoute;
        default:
          return appFallbackRoute;
      }
    } catch (e) {
      log(e.toString());
      throw AbandonedPageNotFoundException();
    }
  }
}
