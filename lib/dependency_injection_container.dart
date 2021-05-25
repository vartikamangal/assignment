import 'package:tatsam_app_experimental/dependency_manager/questionnaire-dpendency-manager.dart';

import 'dependency_manager/core_dependency_managers.dart';
import 'dependency_manager/focus-dependency-manaer.dart';
import 'dependency_manager/hub-dependency-manager.dart';
import 'dependency_manager/instant_relief_dependency_manager.dart';
import 'dependency_manager/path-dependency-manager.dart';
import 'dependency_manager/rapport_building_dependency_manager.dart';
import 'dependency_manager/what-path-to-choose-dependency-manager.dart';
import 'dependency_manager/wheel-of-life-dependency-manager.dart';

Future<void> initializeDependencies() async {
  await initCoreDependencies();
  await initRapportDependencies();
  await initInstantReliefDependencies();
  await initWheelOfLifeDependencies();
  await initFocusDependencies();
  await initJourneyDependencies();
  await initHubDependencies();
  await initPathDependencies();
  await initQuestionnaireDependencies();
}
