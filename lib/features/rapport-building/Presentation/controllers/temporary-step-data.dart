import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

/// Entity for holding contents of post feeling selection rapport pages
class RapportStepData extends Equatable {
  final String dropPageContent;
  final FeelingPageStepContent feelingPageStepContent;

  const RapportStepData({
    @required this.dropPageContent,
    @required this.feelingPageStepContent,
  });

  @override
  List<Object> get props => [dropPageContent, feelingPageStepContent];
}

/// Entity for holding contents of ask-feeling rapport page
class FeelingPageStepContent extends Equatable {
  final String textTop;
  final String textMid;
  final String textBottom;

  const FeelingPageStepContent({
    @required this.textTop,
    @required this.textMid,
    @required this.textBottom,
  });
  @override
  List<Object> get props => [textTop, textMid, textBottom];
}

//////////////////////////////////////////////////////////////
///   TEMPORARY PREDEFINED DATA FOR THE VARIOUS FEELINGS  ///
////////////////////////////////////////////////////////////

const Map<String, RapportStepData> rapportStepData = {
  'VERY_BAD': RapportStepData(
    dropPageContent: "How long have you been feeling this way?",
    feelingPageStepContent: FeelingPageStepContent(
      textTop: "Our thoughts often determine our emotions. ",
      textMid:
          "Can you recall a thought pattern or event that prompted your low emotions?",
      textBottom:
          "Did you know: We cope better with problems when we observe ourselves and emotions, rather than participate in them",
    ),
  ),
  'BAD': RapportStepData(
    dropPageContent:
        "We don’t feel great all the time and that’s completely natural. It is healthy and normal to feel a range of positive and negative emotions, they all have an important role and help us emotionally process life’s events.",
    feelingPageStepContent: FeelingPageStepContent(
      textTop: "Our thoughts often determine our emotions.",
      textMid:
          "Can you recall a thought pattern or event that prompted your low emotions?  ",
      textBottom:
          "Did you know: Our happiness levels change based on the most recent events in our lives?",
    ),
  ),
  'NEUTRAL': RapportStepData(
    dropPageContent:
        "That’s fine! It is important that we feel a range of emotions and sometimes we just feel ‘OK’ or find it difficult to describe what we are really feeling.",
    feelingPageStepContent: FeelingPageStepContent(
      textTop:
          "We often find it difficult to express how we feel with language. People, situations, and places often hold strong associations that help pinpoint our own feelings.",
      textMid:
          "Think of a single word that describes you right now, what would it be?",
      textBottom:
          "Did you know: Moods usually last longer than our emotions which we feel for seconds to minutes, at most...",
    ),
  ),
  'GOOD': RapportStepData(
    dropPageContent:
        "Awesome! Happiness is the emotion we strive for the most.",
    feelingPageStepContent: FeelingPageStepContent(
      textTop:
          "How we feel everyday is closely linked to our life-satisfaction and how we perceive our lives.",
      textMid: "Would you like to learn more about your emotional well-being?",
      textBottom:
          "Did you know: Happiness is impacted by neurological chemicals like dopamine and serotonin, you have the power to change the amount of these in your body",
    ),
  ),
  'VERY_GOOD': RapportStepData(
    dropPageContent:
        "That’s amazing! Happiness is the emotion we strive for the most. Looks like you’ve got things figured out and are in a good place.",
    feelingPageStepContent: FeelingPageStepContent(
      textTop:
          "Our moods are determined by our environment, our actions and our relationships and happiness is a combination of lots of  positive emotions....",
      textMid: "Would you like to learn more about your moods and feelings?",
      textBottom:
          "Did you know: Our happiness levels change based on the most recent events in our lives?",
    ),
  ),
};
