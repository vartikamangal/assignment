// Project imports:
import '../../../core/extensions/url-maker.dart';
import '../../../core/secrets.dart';

abstract class APIRoute {
  const APIRoute._();

  //! Auth UI
  static final String register = "/registration".makeUrl();
  static final String login = "/login".makeUrl();
  static final String userInfo = 'https://${Secrets.AUTH0_DOMAIN}/userinfo';

  //! For Rapport Building Part
  static const String BASE_RAPPORT_URL = "/rapport";
  static final String setSubjectName =
      "$BASE_RAPPORT_URL/user/nickname/add".makeUrl();
  static final String getMoods = "$BASE_RAPPORT_URL/mood/fetch".makeUrl();
  static final String setMood = "$BASE_RAPPORT_URL/mood/track".makeUrl();
  static final String getRapportBuildingSteps =
      "$BASE_RAPPORT_URL/user/mood/selected/".makeUrl();
  static final String getDurationOptions =
      "$BASE_RAPPORT_URL/mood/duration/list".makeUrl();
  static final String setMoodDuration =
      "$BASE_RAPPORT_URL/mood/track/addDuration".makeUrl();

  //! For Wheel of Life part
  static const String BASE_WOL_URL = "/rapport/wol";
  static final String getWolAreas = "$BASE_WOL_URL/area/list".makeUrl();
  static final String prioritizeAreas =
      "$BASE_WOL_URL/area/user/priority".makeUrl();
  static final String getRatingScale =
      "$BASE_WOL_URL/area/rating/scale".makeUrl();
  static final String setUserSatisfaction =
      "$BASE_WOL_URL/area/rating/user".makeUrl();

  //! For instant relief part
  static const String BASE_INSTANT_RELIEF_URL =
      "$BASE_RAPPORT_URL/instant-relief";
  static final String GET_INSTANT_RECOMMENDATIONS =
      //! append /{LIFE_AREA} at last
      "$BASE_INSTANT_RELIEF_URL/recommendation".makeUrl();
  //! append /{recommendation-id}/start at last
  static final String startInstantActivity =
      "$BASE_INSTANT_RELIEF_URL/recommendation".makeUrl();
  static final String listEmergencyNumbers =
      "$BASE_INSTANT_RELIEF_URL/sos/emergency-numbers".makeUrl();
  static final String getInstantReliefAreas =
      "$BASE_INSTANT_RELIEF_URL/areas".makeUrl();

  //! For focus part
  static const String BASE_FOCUS_URL = "$BASE_RAPPORT_URL/focus";
  static final String getAllIssues = "$BASE_FOCUS_URL/list".makeUrl();
  static final String addFocus = "$BASE_FOCUS_URL/user/add".makeUrl();
  static final String deleteFocus = "$BASE_FOCUS_URL/user/delete".makeUrl();

  //! For Journey Part
  static const String BASE_JOURNEY_URL = "/journey";

  /// Append /action-status at last
  static final String getActionWithActionStatus =
      "$BASE_JOURNEY_URL/action".makeUrl();
  static final String getJourneyPathList =
      "$BASE_JOURNEY_URL/path/list".makeUrl();
  static final String startJourney = "$BASE_JOURNEY_URL/start".makeUrl();
  //TODO this one will need to get updated
  static final String updateJounrneyStatus =
      "$BASE_JOURNEY_URL/status/update/{journeyStatus}".makeUrl();

  /// for adding the slected recommendation flow
  //! append /{CATEGORY}/{recommendationId} as last
  static final String addWeeklyActivity =
      '$BASE_JOURNEY_URL/small-wins/recommendation/add'.makeUrl();
  //! Append /weekDay at last
  static final String addWeeklyCategory =
      '$BASE_JOURNEY_URL/category/add/'.makeUrl();

  //! For hub part
  static final String getHubUserStatus = "$BASE_RAPPORT_URL/subject".makeUrl();
  static final String createNewTraveller = "/traveller/create".makeUrl();

  //! For Path/Recommenadtions part
  static const String BASE_RECOMMENDATION_URL = "/recommendation";
  static final String getAllRecommendationCategories =
      "$BASE_RECOMMENDATION_URL/category/list".makeUrl();
  static final String getAllRecommendationsByCategory =
      "$BASE_RECOMMENDATION_URL/user/category/all".makeUrl();
  // Below endpoint is multipurpose, It will be modified for as per our needs, in the Remote Source Itself
  static final String getRecommendationById = BASE_RECOMMENDATION_URL.makeUrl();
  // Fetches plan for GUIDED path
  static final String getActivityScheduleForGuided =
      "$BASE_RECOMMENDATION_URL/big-win/all".makeUrl();
  // For rating the feedback after each completed activity
  static final String rateActivityFeedback =
      "$BASE_RECOMMENDATION_URL/feedback".makeUrl();

  /// Add /{action-time} prefix dynamically during use
  static final String getRecommendationByActionTime =
      '$BASE_RECOMMENDATION_URL/action-time'.makeUrl();

  //! For action updates on Recommendation Flow
  static final String updateActionStatus = "/action".makeUrl();

  //! For Questionnaire Section
  // This gibberish String below is the heardcoded Questionnaire-Id
  // coz. Its same for everybody
  static final String getQuestionnaire =
      "$BASE_RAPPORT_URL/questionnaire".makeUrl();
  static final String attemptQuestions =
      "$BASE_RAPPORT_URL/questions/attempt".makeUrl();

  /// for profile section
  static const String PROFILE_BASE_URL = "/profile";
  static final String getBasicDetails = "$PROFILE_BASE_URL/home".makeUrl();
  static final String getQuestionLogs = "$PROFILE_BASE_URL/questions".makeUrl();
  static final String getMoodLogs = "$PROFILE_BASE_URL/mood".makeUrl();
  static final String getProfileWolData = "$BASE_RAPPORT_URL/subject".makeUrl();
}
