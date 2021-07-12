import 'package:equatable/equatable.dart';

class DidYouKnowPageData extends Equatable {
  final String activityDuration;
  final String activityIcon;
  final String pageTitle;
  final String pageSubtitle;
  final Function onTapNext;

  const DidYouKnowPageData({
    required this.activityDuration,
    required this.activityIcon,
    required this.pageTitle,
    required this.pageSubtitle,
    required this.onTapNext,
  });
  @override
  List<Object> get props =>
      [activityDuration, pageTitle, pageSubtitle, onTapNext, activityIcon];

  @override
  bool get stringify => true;
}
