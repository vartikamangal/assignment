import 'dart:io';

import 'package:get/get.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/snackbars/snackbars.dart';
import '../../domain/entities/emergency-number.dart';
import '../../domain/entities/instant-relief-area.dart';
import '../../domain/usecases/get-instant-relief-areas.dart';
import 'package:flutter/foundation.dart';
import '../../domain/usecases/list-emergency-numbers.dart';

class InstantReliefController extends GetxController {
  // Dependencies
  final GetInstantReliefAreas getInstantReliefAreas;
  final ListEmergencyNumbers listEmergencyNumbers;

  // Data containers
  RxList<InstantReliefArea> instantLifeAreas = RxList([]);
  RxList<EmergencyNumber> emergencyResources = RxList([]);

  // UI management variables
  RxBool isProcessing = RxBool(false);

  // UI management methods
  void toggleProcessor() {
    isProcessing.value = !isProcessing.value;
  }

  Future<void> setup() async {
    toggleProcessor();
    //TODO Still to be done
    //await fetchEmergencyNumbers();
    await fetchInstantActivities();
    toggleProcessor();
  }

  // Usecase helpers
  Future<void> fetchEmergencyNumbers() async {
    final emergencyNumbersOrFailure = await listEmergencyNumbers(NoParams());
    emergencyNumbersOrFailure.fold(
      (failure) {
        ShowSnackbar.rawSnackBar(
          title: '$failure',
          message: 'Failed to fetch SOS resources',
        );
      },
      (numbers) {
        emergencyResources.addAll(numbers);
        stdout.write('Eemrgency Numbers Gotten!');
      },
    );
  }

  Future<void> fetchInstantActivities() async {
    final activitiesOrFailure = await getInstantReliefAreas(NoParams());
    activitiesOrFailure.fold(
      (failure) {
        Get.rawSnackbar(
            title: '$failure', message: 'Failed to fetch activities');
      },
      (instantActivities) {
        instantLifeAreas.addAll(instantActivities);
        stdout.write('Instant Activites Gotten!');
      },
    );
  }

  InstantReliefController({
    @required this.getInstantReliefAreas,
    @required this.listEmergencyNumbers,
  });

  @override
  void onInit() {
    super.onInit();
    setup();
  }
}
