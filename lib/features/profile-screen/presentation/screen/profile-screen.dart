// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/controller/profile-screen-controller.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/widget/bottom-nav-bar.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/widget/landing-profile.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/widget/mood-profile.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/widget/not-answered-question-diary.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/widget/wol-profile.dart';

// Project imports:
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/color-pallete.dart';
import '../../../../features/profile-screen/presentation/widget/answered-question-diary.dart';
import '../../../../features/profile-screen/presentation/widget/my-diary.dart';
import '../../../../core/asset-image-path/image-path.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileScreenController controller = Get.put(ProfileScreenController());
  List<Widget> screens = [
     LandingProfileScreen(),
    WheelOfLifeProfile(),
    MoodProfileScreen(),
    MyDiary(),
    NotAnsweredQuestionDiary()
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
              Navigator.of(context)
                  .pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: blueDarkShade,
              size: ScaleManager.spaceScale(spaceing: 26).value,
            ),
          ),
          actions: [ IconButton(
            onPressed: () {
              //TODO SETTING FUNCTIONALITY
            },
            icon: Image.asset(ImagePath.settingsIcon,height: 26,)
          )],
        ),
        body: Obx(()=>screens[controller.selectedScreenIndex.value]),
        bottomNavigationBar: BottomNavBar()
      ),
    );
  }
}

/*
Obx(()=> BottomNavigationBar(
currentIndex: controller.selectedScreenIndex.value,
selectedItemColor: blueDarkShade,
onTap: controller.selectScreen,
type: BottomNavigationBarType.fixed,
iconSize: 30,
showSelectedLabels: false,   // <-- HERE
showUnselectedLabels: false,
items: const <BottomNavigationBarItem>[
BottomNavigationBarItem(
icon: SizedBox(width:30,child: ImageIcon(AssetImage("assets/profile-icon/profile.png"),)),
label: 'profile',
),
BottomNavigationBarItem(
icon: SizedBox(width:30,child: ImageIcon(AssetImage("assets/profile-icon/wheel.png"),)),
label: 'wheel',
),
BottomNavigationBarItem(
icon: SizedBox(width:30,child: ImageIcon(AssetImage("assets/profile-icon/mood.png"),)),
label: 'mood',
),
BottomNavigationBarItem(
icon: SizedBox(width:30,child: ImageIcon(AssetImage("assets/profile-icon/diary.png"),)),
label: 'profile',
),
BottomNavigationBarItem(
icon: SizedBox(width:30,child: ImageIcon(AssetImage("assets/profile-icon/profile_diary.png"),)),
label: 'profile_diary',
),
],
),)*/
