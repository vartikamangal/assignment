import 'package:equatable/equatable.dart';

/// Entity for holding contents of post feeling selection rapport pages
class RapportData extends Equatable {
  final String dropPageContent;
  final FeelingPageContent feelingPageContent;

  const RapportData({
    required this.dropPageContent,
    required this.feelingPageContent,
  });

  @override
  List<Object> get props => [dropPageContent, feelingPageContent];
}

/// Entity for holding contents of ask-feeling rapport page
class FeelingPageContent extends Equatable {
  final String textTop;
  final String textMid;
  final String textBottom;

  const FeelingPageContent({
    required this.textTop,
    required this.textMid,
    required this.textBottom,
  });
  @override
  List<Object> get props => [textTop, textMid, textBottom];
}

const Map<String, RapportData> rapportData = {
  'SUPER_SAD': RapportData(
    dropPageContent:
        "Oh, we’re sorry to hear that you’re feeling down. Feeling sad is just part of being human, but usually these feelings pass.",
    feelingPageContent: FeelingPageContent(
      textTop:
          "Being super-down may feel all-encompassing at times, but you should also have moments when you are able to laugh or be comforted.",
      textMid:
          "Why don’t you start by telling us more about why you’re super sad right now?",
      textBottom:
          "Did you know: Sadness is an important emotional state and there are varying degrees of sadness",
    ),
  ),
  'SAD': RapportData(
    dropPageContent:
        "Feeling sad is just part of being human, a balance of positive and negative emotional states is actually crucial for our emotional well-being",
    feelingPageContent: FeelingPageContent(
      textTop:
          "Sadness is an important emotional state that helps us explore our vulnerabilities and be more empathetic to others.",
      textMid:
          "Why don’t you start by telling us more about why you’re sad right now?",
      textBottom:
          "Did you know: Sadness is one of the four basic human emotions — the others being happiness, fear and anger. ",
    ),
  ),
  'NEUTRAL': RapportData(
    dropPageContent:
        "We’re always feeling something and sometimes we just feel OK, however sometimes when people ask how we are, we often reply with \"I'm fine\", even when we're not.",
    feelingPageContent: FeelingPageContent(
      textTop:
          "When we are under a lot of stress, we may detach ourselves from our surroundings. ",
      textMid:
          "Think about it a bit more and tell us if there's anything worrying you right now?",
      textBottom:
          "Did you know: While it may appear that most of us can openly discuss how we feel. Studies show that 1 in 3 of us aren’t honest  when asked the question: “How are you feeling today”",
    ),
  ),
  'HAPPY': RapportData(
    dropPageContent:
        "Great! That’s amazing! Happiness is what we all strive for, but we  all need  to feel a balance of both positive and negative emotions.",
    feelingPageContent: FeelingPageContent(
      textTop:
          "Happiness is an emotional state that often depends on our environment, our actions and our relationships.",
      textMid: "Tell us more about what triggered your happiness today?",
      textBottom:
          "Did you know: There are four primary chemicals that drive positive emotions: dopamine, oxytocin, serotonin, and endorphins (this is known as D.O.S.E.)",
    ),
  ),
  'SUPER_HAPPY': RapportData(
    dropPageContent:
        "Feeling positive emotions is good for all of us. Most of us prefer to feel happy all the time, Emotional well-being is all about balance.",
    feelingPageContent: FeelingPageContent(
      textTop:
          "That’s fantastic! Happiness is an important part of mental well-being. Happiness is associated with…..",
      textMid: "What are your secrets to happiness and positivity?",
      textBottom:
          "Did you know: If we felt happy all the time we’d miss out on important emotions that help us improve ourselves, fight for what we believe in and have a sense of purpose.",
    ),
  ),
};
