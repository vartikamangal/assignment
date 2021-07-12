import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/activity-model.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/error/display-error-info.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/entities/instant-relief-area.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/usecases/get-instant-recommendations.dart';

enum PageState { LOADING, LOADED, FAILURE }

class InstantRecommendationsController extends GetxController {
  final GetInstantRecommendations getInstantRecommendations;
  InstantRecommendationsController({
    required this.getInstantRecommendations,
  });

  Rx<PageState> pageStatus = Rx<PageState>(PageState.LOADING);
  RxList<Activity> instantRecommendations = RxList<ActivityModel>([]);

  Future<void> fetchInstantRecommendations({
    required InstantReliefArea instantLifeArea,
  }) async {
    pageStatus.value = PageState.LOADING;
    final recommendationsOrFailure = await getInstantRecommendations(
      GetInstantRecommendationsParams(
        instantLifeArea: instantLifeArea.instantReliefName,
      ),
    );
    recommendationsOrFailure!.fold(
      (failure) {
        //! app should crash here
        pageStatus.value = PageState.FAILURE;
        ErrorInfo.show(failure);
      },
      (fetchedRecommendations) {
        instantRecommendations.assignAll(
          fetchedRecommendations,
        );
        pageStatus.value = PageState.LOADED;
        Get.toNamed(
          RouteName.instantRecommendations,
        );
      },
    );
  }
}
