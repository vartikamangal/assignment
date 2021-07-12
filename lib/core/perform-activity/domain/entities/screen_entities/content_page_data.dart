import 'package:equatable/equatable.dart';

class ContentPageData extends Equatable {
  final String activityIcon;
  final String activityTitle;
  final Function onTapDone;
  final Function onSkip;

  const ContentPageData({
    required this.activityIcon,
    required this.activityTitle,
    required this.onTapDone,
    required this.onSkip,
  });
  @override
  List<Object> get props => [activityIcon, activityTitle, onTapDone, onSkip];

  @override
  bool get stringify => true;
}
