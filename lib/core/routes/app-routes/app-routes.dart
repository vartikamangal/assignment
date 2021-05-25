import 'package:flutter/material.dart';

import '../../../features/focus/presentation/screen/focus-screen.dart';
import '../../../features/focus/presentation/widgets/selected-issue-details.dart';
import '../../../features/hub/presentation/screen/hub-screen.dart';
import '../../../features/instant-relief/presentation/screens/instant-relief-screen.dart';
import '../../../features/opening-screen/presentation/screens/opening_screen.dart';
import '../../../features/path/presentation/widget/guided_path-plan-inside.dart';
import '../../../features/path/presentation/widget/onboarding-incomplete.dart';
import '../../../features/path/presentation/widget/path-guided-plan.dart';
import '../../../features/path/presentation/widget/path-info-section2.dart';
import '../../../features/path/presentation/widget/path-info-section3.dart';
import '../../../features/path/presentation/widget/path-play-section1.dart';
import '../../../features/path/presentation/widget/path-play-section2.dart';
import '../../../features/path/presentation/widget/path-self-driven-plan-inside.dart';
import '../../../features/path/presentation/widget/path-self-driven-plan.dart';
import '../../../features/path/presentation/widget/self-path-info-section1.dart';
import '../../../features/questionnaire-track/presentation/screen/questions-track-screen.dart';
import '../../../features/rapport-building/presentation/screens/rapport_building.dart';
import '../../../features/sign-up/presentation/screen/sign-up-screen.dart';
import '../../../features/what-path-to-choose/presentation/screen/choose-path-screen.dart';
import '../../../features/wheel-of-life-track/presentation/screens/wheel-of-life-screen.dart';
import '../../utils/animations/slide-route-animation-(-y)-axis.dart';
import '../../utils/animations/slide-route-animation-y-axis.dart';
import '../../utils/animations/slide_route_animation-x-axis.dart';

abstract class RouteName {
  static const origin = '/';
  static const rapportPages = '/RapportScreen';
  static const wheelOfLifeScreen = '/wheel_of_life_screen';
  static const focusScreen = '/focus_screen';
  static const hubScreen = '/hub_life_screen';
  static const questionTrackScreen = '/question_track_screen';
  static const whatPathChooseScreen = "/what_path_choose_screen";
  static const instantRelief = "/instant_relief";
  static const selectedIssueDetail = '/selected_issue_detail';
  static const signUpScreen = '/sign_up_screen';
  //guided screens
  static const pathGuidedPlan = '/path_guided_plan';
  static const guidedPathPlanInside = '/guided_path_plan_inside';
  //self driven path screens
  static const pathSelfDrivenPlan = '/self_guided_path1';
  static const pathSelfDrivenPlanInside = '/self_guided_path2';
  static const selfPathInfoSection1 = "/self_path_info_section1";
  static const pathInfoSection2 = '/path_info_section2';
  static const pathInfoSection3 = "/path-info-section3";
  static const playSection1 = '/play-section1';
  static const pathPlaySection2 = '/path-play-section2';
  static const onBoardingIncomplete = '/self_guided_path6';

  RouteName._();
}

class GenerateRoute {
  // ignore: missing_return
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final route = settings.name;
    if (route == RouteName.origin) {
      return MaterialPageRoute(builder: (_) => OpeningScreen());
    }
    if (route == RouteName.rapportPages) {
      return SlideRouteXAxisAnimation(builder: (_) => RapportScreen());
    }
    if (route == RouteName.hubScreen) {
      return SlideRouteXAxisAnimation(builder: (_) => HubScreen());
    }
    if (route == RouteName.wheelOfLifeScreen) {
      return SlideRouteYAxisAnimation(builder: (_) => WheelOfLifeScreen());
    }
    if (route == RouteName.focusScreen) {
      return MaterialPageRoute(builder: (_) => FocusScreen());
    }
    if (route == RouteName.selectedIssueDetail) {
      return SlideRouteXAxisAnimation(builder: (_) => SelectedIssueDetails());
    }
    if (route == RouteName.questionTrackScreen) {
      return SlideRouteXAxisAnimation(builder: (_) => QuestionsTrackScreen());
    }
    if (route == RouteName.whatPathChooseScreen) {
      return SlideRouteNegativeYAxisAnimation(
          builder: (_) => ChoosePathScreen());
    }
    //self guided path screens

    if (route == RouteName.pathSelfDrivenPlan) {
      return SlideRouteXAxisAnimation(builder: (_) => PathSelfDrivenPlan());
    }
    if (route == RouteName.pathSelfDrivenPlanInside) {
      return SlideRouteXAxisAnimation(
          builder: (_) => PathSelfDrivenPlanInside());
    }
    if (route == RouteName.selfPathInfoSection1) {
      return MaterialPageRoute(builder: (_) => SelfPathSection1());
    }
    if (route == RouteName.pathInfoSection2) {
      return MaterialPageRoute(
          builder: (_) => PathInfoSection2());
    }
    if (route == RouteName.pathInfoSection3) {
      return MaterialPageRoute(
          builder: (_) => PathInfoSection3());
    }
    if (route == RouteName.playSection1) {
      return SlideRouteNegativeYAxisAnimation(builder: (_) => PlaySection1());
    }
    if (route == RouteName.pathPlaySection2) {
      return MaterialPageRoute(
          builder: (_) => PathPlaySection2());
    }
    if (route == RouteName.onBoardingIncomplete) {
      return SlideRouteXAxisAnimation(
          builder: (_) => OnBoardingIncomplete());
    }
    //guided screen
    if (route == RouteName.pathGuidedPlan) {
      return SlideRouteXAxisAnimation(builder: (_) => PathGuidedPlan());
    }
    if (route == RouteName.guidedPathPlanInside) {
      return SlideRouteXAxisAnimation(builder: (_) => GuidedPathPlanInside());
    }

    if (route == RouteName.signUpScreen) {
      return SlideRouteNegativeYAxisAnimation(builder: (_) => SignUpScreen());
    }

    if (route == RouteName.instantRelief) {
      //TODO  Use a fadeIn Animation here
      return SlideRouteXAxisAnimation(builder: (_) => InstantReliefScreen());
    }
    if (route == RouteName.signUpScreen) {
      return SlideRouteXAxisAnimation(builder: (_) => SignUpScreen());
    }
  }
}
