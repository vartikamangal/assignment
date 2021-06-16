import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../features/root/presentation/controller/root-controller.dart';

final sl_root = GetIt.instance;

Future<void> initRootDependencies() async {
  //Core
  Get.lazyPut(
    () => RootController(
      retrieveUserOnboardingStatus: sl_root(),
      saveIsFirstTimeOnboardingStatus: sl_root(),
      checkIfAlreadyLoggedIn: sl_root(),
      logAppStartTime: sl_root(),
      getIsMoodPopupShownStatus: sl_root(),
      retirieveLastLoggedAppInit: sl_root(),
      toggleMoodPopupShownState: sl_root(),
    ),
  );
  // Usecases

  // Repos/Services

  // Remote/Local Sources
}
