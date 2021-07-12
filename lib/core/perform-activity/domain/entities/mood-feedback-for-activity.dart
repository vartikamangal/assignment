// Package imports:
import 'package:equatable/equatable.dart';

class MoodFeedbackForActivity extends Equatable {
  final String? mood;
  final String? activityType;
  const MoodFeedbackForActivity({
    required this.mood,
    required this.activityType,
  });
  @override
  List<Object?> get props => [mood, activityType];
}
