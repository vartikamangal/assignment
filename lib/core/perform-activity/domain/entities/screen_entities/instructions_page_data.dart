import 'package:equatable/equatable.dart';

class InstructionsPageData extends Equatable {
  final String activityTitle;
  final String activityDuration;
  final String activityInstructions;
  final Function onTapNext;

  const InstructionsPageData({
    required this.activityTitle,
    required this.activityDuration,
    required this.activityInstructions,
    required this.onTapNext,
  });
  @override
  List<Object> get props =>
      [activityTitle, activityDuration, activityInstructions, onTapNext];

  @override
  bool get stringify => true;
}
