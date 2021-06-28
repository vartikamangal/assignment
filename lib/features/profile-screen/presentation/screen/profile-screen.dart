// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/features/home-management/presentation/controller/home-controller.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/controller/profile-controller.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/widget/answered-question-diary.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/widget/bottom-nav-bar.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/widget/landing-profile.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/widget/mood-profile.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/widget/wol-profile.dart';

import '../../../../core/asset-image-path/image-path.dart';
// Project imports:
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/color-pallete.dart';
import '../../../../features/profile-screen/presentation/widget/my-diary.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.find();
  final HomeController _homeController = Get.find();
  final List<Widget> screens = [
    const LandingProfileScreen(),
    WheelOfLifeProfile(),
    MoodProfileScreen(),
    MyDiary(),
    AnsweredQuestionDiary(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: SvgPicture.asset(
              ImagePath.backButton,
              height: ScaleManager.spaceScale(
                spaceing: 26,
              ).value,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.settingScreen);
                },
                icon: Image.asset(
                  ImagePath.settingsIcon,
                  height: ScaleManager.spaceScale(
                    spaceing: 26,
                  ).value,
                ))
          ],
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : screens[controller.selectedScreenIndex.value],
        ),
        bottomNavigationBar: BottomNavBar(
          mood: _homeController.userMood.value.moodName,
        ),
      ),
    );
  }
}


