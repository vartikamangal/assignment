// Flutter imports:
// Package imports:

import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/activity/presentation/widget/guided_path-plan-inside.dart';
import 'package:tatsam_app_experimental/core/activity/presentation/widget/path-guided-plan.dart';
import 'package:tatsam_app_experimental/core/activity/presentation/widget/path-self-driven-plan-inside.dart';
import 'package:tatsam_app_experimental/core/activity/presentation/widget/path-self-driven-plan.dart';
import 'package:tatsam_app_experimental/core/environment/dev/presentation/dev-opening-screen.dart';
import 'package:tatsam_app_experimental/core/environment/dev/presentation/dev_settings_screen.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/screens/activity_completion_outro.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/screens/activity_root_screen.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/screen/profile-screen.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/widget/setting-screen.dart';
import 'package:tatsam_app_experimental/features/view-all-content/presentation/screens/list-all-activties-screen.dart';

// Project imports:
import '../../../features/focus/presentation/screen/focus-screen.dart';
import '../../../features/focus/presentation/widgets/selected-issue-details.dart';
import '../../../features/home-management/presentation/screens/onboarding-incomplete.dart';
import '../../../features/hub/presentation/screen/hub-screen.dart';
import '../../../features/instant-relief/presentation/screens/instant-recommendations.dart';
import '../../../features/instant-relief/presentation/screens/instant-relief-screen.dart';
import '../../../features/opening-screen/presentation/screens/opening_screen.dart';
import '../../../features/questionnaire-track/presentation/screen/questions-track-screen.dart';
import '../../../features/rapport-building/presentation/screens/rapport_building.dart';
import '../../../features/root/presentation/screen/root-view.dart';
import '../../../features/sign-up/presentation/screen/sign-up-screen.dart';
import '../../../features/what-path-to-choose/presentation/screen/choose-path-screen.dart';
import '../../../features/wheel-of-life-track/presentation/screens/wheel-of-life-screen.dart';
import '../../auth/presentation/screens/auth-screen-test.dart';
import '../../environment/dev/presentation/dev_root_screen.dart';

abstract class RouteName {
  static const origin = '/';
  static const devRootScreen = '/dev/root';
  static const originDevOpeningScreen = '/dev/opning-screen';
  static const rootView = '/root';
  static const authview = '/authview';
  static const rapportPages = '/rapport';
  static const wheelOfLifeScreen = '/wheel-of-life';
  static const focusScreen = '/focus';
  static const issueDetail = '/issue';
  static const hubScreen = '/hub';
  static const questionTrackScreen = '/questions';
  static const whatPathChooseScreen = "/what-path-choose-screen";
  static const instantRelief = "/instant-relief";
  static const instantRecommendations = "/instant-recommendations";
  static const selectedIssueDetail = '/selected-issue-detail';
  static const signUpScreen = '/sign-up-screen';
  //guided screens
  static const pathGuidedPlan = '/guided-plan';
  static const guidedPathPlanInside = '/guided-plan-details';
  //self driven path screens
  static const pathSelfDrivenPlan = '/self-driven-plan';
  static const pathSelfDrivenPlanInside = '/self-driven-plan-details';
  static const selfPathInfoSection1 = "/path-info-a";
  static const pathInfoSection2 = '/path-info-b';
  static const pathInfoSection3 = "/path-info-c";
  static const playSection1 = '/path-complete-outro';
  static const pathPlaySection2 = '/path-play-section2';
  static const onBoardingIncomplete = '/onboarding-screen';
  static const profileScreen = '/profile_screen';
  static const settingScreen = '/setting_screen';
  static const activityScreen = "/activity";
  static const activityCompletionScreen = "/activity/complete";
  static const listAllActivities = "/list-all-activities";
  static const devSettingsScreen = "/dev/settings";
  RouteName._();
}

class GenerateRoute {
  // ignore: missing_return
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final route = settings.name;
    if (route == RouteName.origin) {
      return PageTransition(
        child: OpeningScreen(),
        type: PageTransitionType.fade,
      );
    }
    if (route == RouteName.devRootScreen) {
      return PageTransition(
        child: const DevRootView(),
        type: PageTransitionType.fade,
      );
    }
    if (route == RouteName.originDevOpeningScreen) {
      return PageTransition(
        child: const DevOpeningScreen(),
        type: PageTransitionType.fade,
      );
    }
    if (route == RouteName.rootView) {
      return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, secondaryAnimation) => RootView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
      );
    }
    if (route == RouteName.authview) {
      return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, secondaryAnimation) => AuthScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
      );
    }
    if (route == RouteName.instantRecommendations) {
      return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, secondaryAnimation) =>
            InstantRecommendationsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.scaled,
          child: child,
        ),
      );
    }
    if (route == RouteName.rapportPages) {
      return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, secondaryAnimation) =>
            RapportScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      );
    }
    if (route == RouteName.hubScreen) {
      return CupertinoPageRoute(
        builder: (context) => HubScreen(),
      );
    }
    if (route == RouteName.wheelOfLifeScreen) {
      return PageTransition(
        child: WheelOfLifeScreen(),
        type: PageTransitionType.bottomToTop,
      );
    }
    if (route == RouteName.focusScreen) {
      return PageTransition(
        child: FocusScreen(),
        type: PageTransitionType.fade,
      );
    }

    if (route == RouteName.selectedIssueDetail) {
      return MaterialPageRoute(builder: (_) => SelectedIssueDetails());
    }
    if (route == RouteName.questionTrackScreen) {
      return CupertinoPageRoute(
        builder: (context) => QuestionsTrackScreen(),
      );
    }
    if (route == RouteName.whatPathChooseScreen) {
      return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
            ChoosePathScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
      );
    }

    if (route == RouteName.pathSelfDrivenPlan) {
      return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, secondaryAnimation) =>
            PathSelfDrivenPlan(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      );
    }
    if (route == RouteName.pathSelfDrivenPlanInside) {
      return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, secondaryAnimation) =>
            PathSelfDrivenPlanInside(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      );
    }
    if (route == RouteName.onBoardingIncomplete) {
      return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, secondaryAnimation) =>
            OnBoardingIncomplete(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      );
    }
    //guided screen
    if (route == RouteName.pathGuidedPlan) {
      return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, secondaryAnimation) =>
            PathGuidedPlan(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      );
    }
    if (route == RouteName.guidedPathPlanInside) {
      return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, secondaryAnimation) =>
            GuidedPathPlanInside(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      );
      // return SlideRouteXAxisAnimation(builder: (_) => GuidedPathPlanInside());
    }

    if (route == RouteName.instantRelief) {
      return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, secondaryAnimation) =>
            InstantReliefScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      );
    }
    if (route == RouteName.signUpScreen) {
      return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, secondaryAnimation) => SignUpScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      );
    }
    if (route == RouteName.profileScreen) {
      return CupertinoPageRoute(
        builder: (context) => ProfileScreen(),
      );
    }
    if (route == RouteName.settingScreen) {
      return CupertinoPageRoute(
        builder: (context) => SettingScreen(),
      );
    }
    if (route == RouteName.activityScreen) {
      final args = settings.arguments as Map<String, dynamic>;
      final redirectRoute = args["redirectRoute"] as String;
      final activity = args["activity"] as Activity;
      final isInstantActivity = args["isInstantActivity"] as bool;
      return PageRouteBuilder(
        reverseTransitionDuration: const Duration(),
        transitionDuration: const Duration(),
        pageBuilder: (context, animation, secondaryAnimation) =>
            ActivityRootScreen(
          activity: activity,
          redirectRoute: redirectRoute,
          isInstantActivity: isInstantActivity,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
      );
    }
    if (route == RouteName.activityCompletionScreen) {
      return PageRouteBuilder(
        reverseTransitionDuration: const Duration(),
        transitionDuration: const Duration(),
        pageBuilder: (context, animation, secondaryAnimation) =>
            ActivityCompletionOutro(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
      );
    }
    if (route == RouteName.listAllActivities) {
      return MaterialPageRoute(
        builder: (context) => const ListAllActivitiesScreen(),
      );
    }
    if (route == RouteName.devSettingsScreen) {
      return PageRouteBuilder(
        reverseTransitionDuration: const Duration(),
        transitionDuration: const Duration(),
        pageBuilder: (context, animation, secondaryAnimation) =>
            DevSettingsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
      );
    } else {
      log("<------------ Going to fallback route ------------>");
      return PageTransition(
        child: OpeningScreen(),
        type: PageTransitionType.fade,
      );
    }
  }
}
