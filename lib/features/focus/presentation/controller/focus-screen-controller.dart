import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/snackbars/snackbars.dart';
import '../../data/models/issue-model.dart';
import '../../domain/entities/issue.dart';
import '../../domain/usecases/add-issue.dart';
import '../../domain/usecases/get-issues.dart';
import '../../../hub/presentation/controller/hub-controller.dart';

class FocusController extends GetxController {
  // usecases
  final GetIssues getIssues;
  final SetTarget setTarget;

  FocusController({
    @required this.getIssues,
    @required this.setTarget,
  });

  ///////////               ////////////
  ///////////  Dynamic Data Helpers ////
  ///////////               ///////////
  final RxList<Issue> issues = RxList<IssueModel>([]);

  ///////////               ////////////
  /////////// UseCase helpers //////////
  ///////////               ///////////
  Future<void> fetchIssues() async {
    final gottenIssueOrFailure = await getIssues(NoParams());
    gottenIssueOrFailure.fold(
      (failure) {
        ShowSnackbar.rawSnackBar(
          title: '$failure',
          message: 'Something went wrong!',
        );
      },
      (fetchedIssues) {
        log('Fetched all focus areas');
        issues.assignAll(fetchedIssues);
      },
    );
  }

  Future<void> addIssue() async {
    toggleProcessor();
    final issueAddedOrFailure = await setTarget(
      SetTargetParams(
        issue: selectedIssue.value,
      ),
    );
    toggleProcessor();
    issueAddedOrFailure.fold(
      (failure) {
        ShowSnackbar.rawSnackBar(
          title: '$failure',
          message: 'Something went wrong!',
        );
      },
      (issueSaved) {
        log("Saved user's current focus");
        Get.offNamed(
          RouteName.selectedIssueDetail,
        );
        Future.delayed(const Duration(milliseconds: 1000), () {
          // For refreshing the status of HubScreen
          Get.find<HubController>().fetchHubStatus();
          Get.offAllNamed(RouteName.hubScreen);
        });
      },
    );
  }

  ///////////               ////////////
  /////////// UI MANAGEMENT ////////////
  ///////////               ///////////

  // used for overall module loading stats
  RxBool isLoading = RxBool(false);
  // used for porcessing events like post feedbacks
  RxBool isProcessing = RxBool(false);
  RxDouble topExpandedContainer = RxDouble(0.0);
  String selectedIssueImage = '';
  String text1 = tr('focus title1');
  List<String> cart = [];
  bool optionSelected = false;
  Rx<Issue> selectedIssue = Rx<IssueModel>();

  void toggleProcessor() {
    isProcessing.value = !isProcessing.value;
  }

  void toggleLoader() {
    isLoading.value = !isLoading.value;
  }

  void getDescription(String image, Issue issue) {
    topExpandedContainer.value = Get.height * 0.5;
    selectedIssueImage = image;
    selectedIssue.value = issue;
    update();
  }

  // Custom navigator
  void navigateBack() {
    topExpandedContainer.value = 0.0;
  }

  Future<void> setup() async {
    toggleLoader();
    await fetchIssues();
    toggleLoader();
  }

  void selectedOption() {
    optionSelected = true;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await setup();
  }
}
