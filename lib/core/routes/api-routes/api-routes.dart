import '../../../core/extensions/url-maker.dart';

abstract class APIRoute {
  //! For Rapport Building Part
  static final String setSubjectName = "/user/nickname/add".makeUrl();
  static final String getMoods = "/mood/fetch".makeUrl();
  static final String setMood = "/mood/track".makeUrl();
  static final String getRapportBuildingSteps =
      "/user/mood/selected/".makeUrl();
  static final String getDurationOptions = "/mood/duration/list".makeUrl();
  static final String setMoodDuration = "/mood/track/addDuration".makeUrl();

  //! For Wheel of Life part
  static final String getWolAreas = "/wol/area/list".makeUrl();
  static final String prioritizeAreas = "/wol/area/user/priority".makeUrl();
  static final String getRatingScale = "/wol/area/rating/scale".makeUrl();
  static final String setUserSatisfaction = "/wol/area/rating/user".makeUrl();

  //! For instant relief part
  static final String listEmergencyNumbers =
      "/instant-relief/sos/emergency-numbers".makeUrl();
  static final String getInstantReliefAreas = "/instant-relief/areas".makeUrl();

  //! For focus part
  static final String getAllIssues = "/focus/list".makeUrl();
  static final String addFocus = "/focus/user/add".makeUrl();
  static final String deleteFocus = "/focus/user/delete".makeUrl();

  //! For Journey Part
  static final String getJourneyPathList = "/journey/path/list".makeUrl();
  static final String startJourney = "/journey/start".makeUrl();
  //TODO this one will need to get updated
  static final String updateJounrneyStatus =
      "/journey/status/update/{journeyStatus}".makeUrl();

  //! For hub part
  static final String getHubUserStatus = "/subject".makeUrl();
  static final String createNewTraveller = "/traveller/create".makeUrl();

  //! For Path/Recommenadtions part
  static final String getAllRecommendationCategories =
      "/recommendation/category/list".makeUrl();
  static final String getAllRecommendationsByCategory =
      "/recommendation/user/category/all".makeUrl();
  // Below endpoint is multipurpose, It will be modified for as per our needs, in the Remote Source Itself
  static final String getRecommendationById = "/recommendation".makeUrl();
  // Fetches plan for GUIDED path
  static final String getActivityScheduleForGuided =
      "/recommendation/big-win/all".makeUrl();

  //! For action updates on Recommendation Flow
  static final String updateActionStatus = "/action".makeUrl();

  //! For Questionnaire Section
  // This gibberish String below is the heardcoded Questionnaire-Id
  // coz. Its same for everybody
  static final String getQuestionnaire = "/questionnaire".makeUrl();
  static final String attemptQuestions = "/questions/attempt".makeUrl();

  const APIRoute._();
}
