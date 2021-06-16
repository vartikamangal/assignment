// Holds the key values for persisted data members
abstract class PersistenceConst {
  PersistenceConst._();
  // for opening the main box
  static String CORE_BOX = "core";
  // Save point of device id
  static String CORE_DEVICE_ID = "core-device-id";
  // Save point of username
  static String CORE_USER_NAME = "core-username";
  // Saves the latest seubjectInfo obtained from header
  static String CORE_SUBJECT_INFO_FOR_HEADER = "core-subject-info-header";
  // Saves the latest jounrey obtained from header
  static String CORE_JOURNEY_FOR_HEADER = "core-journey-header";
  // Saves the latest travellerInfo obtained from header
  static String CORE_TRAVELLER_INFO_FOR_HEADER = "core-traveller-info-header";
  // Saves the feeling, that user typed inside the rapport-last-screen
  static String RAPPORT_FEELING_BOX = "rapport-feeling";
  // Saves the (bool), which confirms wheather user saved anything in voice note of rapport or not
  static String RAPPORT_IS_FEELING_VOICENOTE_EMPTY_BOX = "rapport-feeling";
  // Saves the voiceNote{filePath} that user (if)spoke inside the rapport-last-screen
  static String RAPPORT_FEELING_VOICENOTE_BOX = "rapport-feeling";
  // Holds the persisted data that user enetered after activity completion
  static String RECOMMENDATION_INPUTS = "rapport-feeling";
  // Holds the persisted value of path selected by user on what-path-to-choose screen
  static String USER_SELECTED_PATH = "user-path";
  // Stores the most recent activity completed by user
  static String MOST_RECENT_ACITIVITY = "most-recent-acitivty";
  // Stores the user Onboarding status
  static String USER_ONBOARDING_STATUS = "user-onboarding-status";
  // Stores the user status on app, For showing onboarding screen for the first time
  static String IS_FIST_TIME_USER = "first-time-user";
  // Will store a bool value of have we shown today's mood popup to the user
  static String MOOD_POPUP_SHOWN = "is-mood-popup-shown";
  // Key value for the user mood store
  static String USER_MOOD = "user-mood";
  // Stores the key for refresh token
  static String ACCESS_TOKEN = "access-token";
  // Stores the userData
  static String USER_DATA = "user-data";
  // Stores the serialized AppDurationModel object
  static String USER_DURATION_ON_APP = "user-duration-on-app";
  // Stores the dattime object for when the app was opened last time
  static String LAST_OPENED_APP = "last-opened-app";
}
