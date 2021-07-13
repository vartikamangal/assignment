// Dart imports:
import 'dart:developer';
import 'dart:io';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatsam_app_experimental/core/auth/domain/usecases/check-if-already-logged-in.dart';
import 'package:tatsam_app_experimental/core/error/display-error-info.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/models/instant-relief-area-model.dart';

// Project imports:
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/emergency-number.dart';
import '../../domain/entities/instant-relief-area.dart';
import '../../domain/usecases/get-instant-relief-areas.dart';
import '../../domain/usecases/list-emergency-numbers.dart';

class InstantReliefController extends GetxController {
  // Dependencies
  final GetInstantReliefAreas getInstantReliefAreas;
  final ListEmergencyNumbers listEmergencyNumbers;

  /// In diffn. controller!!
  final CheckIfAuthenticated checkIfAuthenticated;

  InstantReliefController({
    required this.getInstantReliefAreas,
    required this.listEmergencyNumbers,
    required this.checkIfAuthenticated,
  });

  // Data containers
  RxList<InstantReliefArea> instantLifeAreas = RxList([]);
  RxList<EmergencyNumber> emergencyResources = RxList([]);

  // RxBool isLoggingIn = RxBool(false);

  // UI management variables
  RxBool isProcessing = RxBool(false);
  Rxn<InstantReliefArea> selectedArea = Rxn<InstantReliefAreaModel>();

  // UI management methods
  void toggleProcessor() {
    isProcessing.value = !isProcessing.value;
  }

  Future<void> setup() async {
    toggleProcessor();
    print("hi");
    //TODO Still to be done
    //await fetchEmergencyNumbers();
    await fetchInstantActivities();
    toggleProcessor();
  }

  // ignore: avoid_setters_without_getters
  set instantReliefArea(InstantReliefAreaModel instantReliefArea) {
    selectedArea.value = instantReliefArea;
  }

  // Usecase helpers
  Future<void> fetchEmergencyNumbers() async {
    final emergencyNumbersOrFailure = await listEmergencyNumbers(
      NoParams(),
    );
    emergencyNumbersOrFailure!.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (numbers) {
        emergencyResources.addAll(numbers);
        stdout.write(
          'Eemrgency Numbers Gotten!',
        );
      },
    );
  }

  Future<void> fetchInstantActivities() async {
    final activitiesOrFailure = await getInstantReliefAreas(NoParams());
    activitiesOrFailure!.fold(
      (failure) {
        ErrorInfo.show(failure);
        print("hello");
      },
      (instantActivities) {
        instantLifeAreas.addAll(instantActivities);
        print("hello");
        stdout.write(
          'Instant Activites Gotten!',
        );
      },
    );
  }

  //TODO Not responsibility of thios screen!! move to next one
  /// returns [Future] true if user is logged in in this device, else false
  Future<bool> checkUserLoginStatus() async {
    final successOrFailure = await checkIfAuthenticated(
      NoParams(),
    );
    return successOrFailure.fold(
      (f) {
        log('user not logged in');
        return false;
      },
      (r) {
        return r;
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    setup();
  }
}

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    Key? key,
    required this.onPressed,
    required this.isLoggingIn,
  }) : super(key: key);

  final Callback onPressed;
  final bool isLoggingIn;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ScaleManager.spaceScale(
          spaceing: 12,
        ).value,
      ),
      decoration: BoxDecoration(
          color: Get.theme.canvasColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              ScaleManager.spaceScale(
                spaceing: 6,
              ).value,
            ),
          )),
      height: ScaleManager.spaceScale(
        spaceing: 200,
      ).value,
      child: Column(
        children: [
          Icon(
            Icons.warning,
            size: ScaleManager.spaceScale(
              spaceing: 65,
            ).value,
            color: Colors.redAccent,
          ),
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 8,
            ).value,
          ),
          Text(
            "This feature requires signin",
            style: GoogleFonts.poppins(
              color: Colors.red,
              fontSize: 18,
            ),
            textScaleFactor: ScaleManager.textScale.value,
          ),
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 22,
            ).value,
          ),
          OutlinedButton.icon(
            icon: isLoggingIn
                ? Center(
                    child: SizedBox(
                      height: ScaleManager.spaceScale(
                        spaceing: 12,
                      ).value,
                      width: ScaleManager.spaceScale(
                        spaceing: 12,
                      ).value,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : const Icon(
                    Icons.login,
                  ),
            label: Text(
              isLoggingIn ? '' : 'Sign in',
            ),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
