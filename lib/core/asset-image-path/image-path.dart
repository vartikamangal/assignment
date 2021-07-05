// Project imports:
import 'asset-path-maker.dart';

class ImagePath {
  //Opening Screen
  static final String mountain="/opening-screen/images/mountain_bg.png".makePath();
  static final String tagLine="/opening-screen/images/tatsam_tagline.png".makePath();
  static final String logo="/opening-screen/images/tatsam_logo.png".makePath();
  static final String greenVectors="/opening-screen/images/green_vector.png".makePath();
  static final String purpleVector="/opening-screen/images/purple_vector.png".makePath();
  static final String holdingLeaf="/opening-screen/images/holding_leaf.png".makePath();

  //ON RAPPORT PAGE
  static final String emojiList = "/Rapport-screen/images".makePath();
  static final String topRightLeaf =
      "/Rapport-screen/images/topRightLeaf.png".makePath();
  static final String lightBlueEmoji = "/Rapport_light_image/".makePath();
  static final String callButton =
      '/Rapport-screen/images/call_button.svg'.makePath();

  //ON HUB SCREEN
  static final String hubLife = "/hub/life-screen-image.png".makePath();
  static final String hubTarget = "/hub/target-screen-image.png".makePath();
  static final String hubSymptoms = "/hub/symptoms-screen-image.png".makePath();
  static final String hubAllAnswered =
      "/hub/all-answered-screen.png".makePath();
  //ON FOCUS SCREEN
  static final String issues = "/focus-screen/".makePath();

  //ON WHAT-PATH-TO-CHOOSE-SCREEN
  static final String option1 =
      "/choose-path-screen/path-option1.png".makePath();
  static final String path1Image =
      "/choose-path-screen/selected-path1-image.png".makePath();
  static final String path2Image =
      "/choose-path-screen/selected-path2.png".makePath();
  static final String option2 =
      "/choose-path-screen/path-option2.png".makePath();
  static final String backGroundImage =
      "/choose-path-screen/path-choose-screen-image.png".makePath();

  //Universal Images
  static final String micImage = "/universal_images/mic.svg".makePath();
  static final String connectionStatus = "/universal_images/connection_status.svg".makePath();
  static final String crossIcon = "/universal_images/cross_icon.svg".makePath();
  static final String grid = "/universal_images/grid.svg".makePath();
  static final String backButton='/universal_images/back_button.png'.makePath();
  static final String forwardIcon='/universal_images/forward_icon.svg'.makePath();
  static final String playButton='/universal_images/play_icon.svg'.makePath();
  static final String crossButton='/universal_images/cross_button.svg'.makePath();
  static final String emptyStateEmoji='/universal_images/empty-state-image.svg'.makePath();

  //Your Path screen
  //self driven path
  static final String selfDrivenOption =
      "/path/self-driven-path/select-option/".makePath();
  static final String selectedOptionFields =
      "/path/self-driven-path/".makePath();

  //guided-path
  static final String guidedOption =
      "/path/guided-path/select-option/".makePath();
  static final String dayTasks = "/path/guided-path/".makePath();

  //OnBoarding Incomplete
  static final String onBoardingIncompleteImage =
      "/onboarding-incomplete/image.png".makePath();
  static final String cornerImage =
      "/onboarding-incomplete/corner-image.png".makePath();
  //Profile screen
  static final String userImage="/profile-icon/user-image.png".makePath();
  static final String settingsIcon="/profile-icon/setting-icon.png".makePath();
  static final String happyEmoji="/profile-icon/happy.png".makePath();
  static final String sadEmoji="/profile-icon/sad.png".makePath();
  static final String lockImage="/profile-icon/lock-image.png".makePath();
  static final String chartLock="/profile-icon/chart-lock.png".makePath();
  static final String profileIcon='/profile-icon/profile.svg'.makePath();
  static final String moodIcon='/profile-icon/mood.svg'.makePath();
  static final String wheelIcon='/profile-icon/wheel.svg'.makePath();
  static final String diaryIcon='/profile-icon/diary.svg'.makePath();
  static final String profileDiaryIcon ='/profile-icon/profile_diary.svg'.makePath();
}
