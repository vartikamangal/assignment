import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/core/utils/snackbars/snackbars.dart';
import 'package:tatsam_app_experimental/features/hub/presentation/controller/hub-controller.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-option-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/questionnaire-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question-option.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/questionnaire.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/usecases/attempt-questions.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/usecases/get-questionnaire-by-id.dart';

class QuestionnaireConroller extends GetxController {
  ///////// Usecases /////////////
  final GetQuestionnaireById getQuestionnaireById;
  final AtemptQuestions atemptQuestions;

  QuestionnaireConroller({
    @required this.getQuestionnaireById,
    @required this.atemptQuestions,
  });
  //////// Dynamic Data Holders ///////////
  Rx<Questionnaire> questionnaire = Rx<QuestionnaireModel>();
  RxMap<Question, dynamic> questionToAnswerMap = RxMap<QuestionModel, dynamic>(
    {},
  );
  // Will tell the status of various dropdowns
  RxMap<Question, bool> dropDownStatus = RxMap<QuestionModel, bool>(
    {},
  );
  // Will keep a track of various rating-scales valid for different rating-type questions
  RxMap<Question, QuestionOption> questionToScaleMap =
      RxMap<QuestionModel, QuestionOption>(
    {},
  );
  ///////  Usecase Helpers //////////
  Future<void> fetchQuestionnaire() async {
    final questionnaireOrFailure = await getQuestionnaireById(
      const GetQuestionnaireByIdParams(
        id: 'f8c3de3d-1fea-4d7c-a8b0-29f63c4c3454',
      ),
    );
    questionnaireOrFailure.fold(
      (failure) {
        ShowSnackbar.rawSnackBar(
          title: failure.toString(),
          message: 'Something went wrong!',
        );
      },
      (fetchedQuestionnaire) {
        questionnaire.value = fetchedQuestionnaire;
        // ignore: avoid_function_literals_in_foreach_calls
        questionnaire.value.questionVO.forEach(
          (question) {
            log(question.questionOptionVO.toString());
            questionToAnswerMap.addIf(
              question.questionType == 'RATING_SCALE',
              question as QuestionModel,
              1.0,
            );
            questionToScaleMap.addIf(
              question.questionType == 'RATING_SCALE',
              question as QuestionModel,
              question.questionOptionVO[0],
            );
            questionToAnswerMap.addIf(
              question.questionType == 'SINGLE_CHOICE',
              question as QuestionModel,
              // When user opts any answer N/A will be replaced by QuestionOptionModel
              'Select',
            );
            dropDownStatus.addIf(
              question.questionType == 'SINGLE_CHOICE',
              question as QuestionModel,
              // When user opts any answer N/A will be replaced by QuestionOptionModel
              false,
            );
          },
        );
        log('questionnaire fetched!');
      },
    );
  }

  Future<void> attempQuestionsTrigger() async {
    toggleProcessor();
    final questionAttemptedOrFailure = await atemptQuestions(
      AttemptQuestionnaireParams(
        questionToAnswerMap: questionToAnswerMap,
        questionToScaleMap: questionToScaleMap,
        questionnaire: questionnaire.value,
      ),
    );
    toggleProcessor();
    questionAttemptedOrFailure.fold(
      (failure) {
        ShowSnackbar.rawSnackBar(
          title: failure.toString(),
          message: 'Something went wrong!',
        );
      },
      (attemptStatus) async {
        log('successfully attempted questions!');
        await Get.find<HubController>().fetchHubStatusFinal().then(
              (value) => Get.offNamed(
                RouteName.hubScreen,
              ),
            );
      },
    );
  }

  ///////// UI Helpers /////////////

  // Will help the in appearence
  ScrollController scrollController = ScrollController();
  RxBool toShowBottomBtn = RxBool(false);
  RxBool isLoading = RxBool(false);
  RxBool isProcessing = RxBool(false);

  void toggleBottomButtonVisibility({
    double position,
    double maxPageLimit,
  }) {
    if (position < maxPageLimit) {
      toShowBottomBtn.value = false;
    } else {
      toShowBottomBtn.value = true;
    }
  }

  void toggleDropdown({
    @required QuestionModel questionModel,
  }) {
    dropDownStatus[questionModel] = !dropDownStatus[questionModel];
  }

  void answerMcqTypeQuestion({
    @required QuestionModel questionModel,
    @required QuestionOptionModel optionSelected,
  }) {
    // Sets the answer we have selected as preffered answer
    questionToAnswerMap[questionModel] = optionSelected;
    // Closes the dropdown
    toggleDropdown(questionModel: questionModel);
  }

  void toggleLoader() {
    isLoading.value = !isLoading.value;
  }

  void toggleProcessor() {
    isProcessing.value = !isProcessing.value;
  }

  Future<void> setup() async {
    toggleLoader();
    await fetchQuestionnaire();
    toggleLoader();
  }

  void updateQuizValues({
    @required Question question,
    @required dynamic option,
  }) {
    questionToAnswerMap[question] = option;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await setup();
    scrollController.addListener(
      () {
        toggleBottomButtonVisibility(
          position: scrollController.position.pixels,
          maxPageLimit: scrollController.position.maxScrollExtent,
        );
      },
    );
  }
}
