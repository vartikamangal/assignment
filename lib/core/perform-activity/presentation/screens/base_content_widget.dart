import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/widgets/activity_type_widgets/audio-based-activity-widget.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/widgets/activity_type_widgets/text-based-activity-widget.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/widgets/activity_type_widgets/video-based-activity-widget.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-state.dart';

/// Base Interface
abstract class BaseContentWidget extends StatelessWidget {}

/// Factory Class
class ContentWidgetFactory {
  static final Map<String, BaseContentWidget Function()> _templateNameToWidget =
      {
    "PLAIN_TEXT": () => TextBasedActivity(),
    "PLAIN_TEXT_WITH_ICON": () => TextBasedActivity(),
    "AUDIO_CONTENT": () => VideoBasedActivity(),
    "VIDEO_CONTENT": () => AudioBasedActivity(),
  };

  static bool isTemplateNameSupported({required String templateName}) =>
      _templateNameToWidget.containsKey(templateName);

  static BaseContentWidget getContentWidget({required String templateName}) {
    final result = _templateNameToWidget[templateName];
    if (result != null) {
      return result();
    } else {
      return ContentNotSupported();
    }
  }
}

class ContentNotSupported extends BaseContentWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      /// Shitty name, but EmptyState --> ErrorStateUI
      child: EmptyState(
        text: "Oops! Something went wrong",
      ),
    );
  }
}

class ContentInitializing extends BaseContentWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
