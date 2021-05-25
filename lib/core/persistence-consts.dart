// Holds the key values for persisted data members
abstract class PersistenceConst {
  PersistenceConst._();
  // for opening the main box
  static String CORE_BOX = "core";
  // Save point of device id
  static String CORE_DEVICE_ID = "core-device-id";
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
}
