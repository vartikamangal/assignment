// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tatsam_app_experimental/core/error/display-error-info.dart';

// Project imports:
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../hub/presentation/controller/hub-controller.dart';
import '../../data/models/issue-model.dart';
import '../../domain/entities/issue.dart';
import '../../domain/usecases/add-issue.dart';
import '../../domain/usecases/get-issues.dart';

class FocusController extends GetxController {
  // usecases
  final GetIssues getIssues;
  final SetTarget setTarget;

  FocusController({
    required this.getIssues,
    required this.setTarget,
  });

  ///////////               ////////////
  ///////////  Dynamic Data Helpers ////
  ///////////               ///////////
  final RxList<Issue?> issues = RxList<IssueModel?>([]);

  ///////////               ////////////
  /////////// UseCase helpers //////////
  ///////////               ///////////
  Future<void> fetchIssues() async {
    final gottenIssueOrFailure = await getIssues(NoParams());
    gottenIssueOrFailure!.fold(
      (failure) {
        ErrorInfo.show(failure);
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
    issueAddedOrFailure!.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (issueSaved) {
        log("Saved user's current focus");
        Get.offNamed(
          RouteName.selectedIssueDetail,
        );
        Future.delayed(const Duration(milliseconds: 1500), () async {
          // For refreshing the status of HubScreen
          await Get.find<HubController>().fetchHubStatus().then((value) {
            // coz. two pages back Hub screen is present and currenlty popUntill is breaking
            Get.back();
            // Get.back();
          });
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
  Rxn<Issue> selectedIssue = Rxn<IssueModel>();
  RxInt count = 0.obs;
  RxList<Issue?> removedItem = RxList<IssueModel?>([]);

  void toggleProcessor() {
    isProcessing.value = !isProcessing.value;
  }

  void toggleLoader() {
    isLoading.value = !isLoading.value;
  }

  void removeIssue(Issue? issue) {
    count++;
    issues.removeWhere((element) => element!.focusName == issue!.focusName);
    count > 1
        ? issues.add(removedItem.value[removedItem.length - 1])
        : print("");
    removedItem.add(selectedIssue.value);
  }

  void getDescription(String image, Issue? issue) {
    if (topExpandedContainer.value != Get.height * 0.5) {
      topExpandedContainer.value = Get.height * 0.5;
    } else {
      topExpandedContainer.value = 0.0;
      Future.delayed(const Duration(milliseconds: 400), () async {
        topExpandedContainer.value = Get.height * 0.5;
      });
    }
    selectedIssueImage = image;
    selectedIssue.value = issue;
    update();
  }

  // Custom navigator
  void navigateBack() {
    count.value = 0;
    issues.add(selectedIssue.value);
    issues.toSet();
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
