// Flutter imports:

// Project imports:
import '../../../../core/image/image.dart';
import '../../domain/entities/issue.dart';

class IssueModel extends Issue {
  IssueModel({
    required int? issueId,
    required String? focusName,
    required String? displayName,
    required String? messageOnSelection,
    required ImageModel? issueIcon,
  }) : super(
          messageOnSelection: messageOnSelection,
          issueIcon: issueIcon?.toDomain(),
          issueId: issueId,
          focusName: focusName,
          displayName: displayName,
        );

  factory IssueModel.fromJson(Map<String, dynamic> jsonMap) {
    return IssueModel(
      issueId: jsonMap['id'] as int?,
      focusName: jsonMap['focusName'] as String?,
      displayName: jsonMap['displayName'] as String?,
      messageOnSelection: jsonMap['messageOnSelection'] as String?,
      issueIcon: jsonMap['icon'] == null
          ? ImageModel.fallbackIcon()
          : ImageModel.fromJson(jsonMap['icon'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": issueId,
      "displayName": displayName,
      "messageOnSelection": messageOnSelection,
      "focusName": focusName,
      "iconVO": ImageModel.fromDomain(issueIcon!).toJson(),
    };
  }
}
