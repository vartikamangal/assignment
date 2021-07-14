// Flutter imports:

// Project imports:
import 'package:tatsam_app_experimental/features/view-all-content/data/models/data-model.dart';

import '../../domain/entities/tag.dart';

class TagModel extends DataModel<Tag> {
  String? name;
  String? tagCategory;
  String? displayName;
  String? parentName;

  TagModel.fromJson(Map<String, dynamic> jsonMap)
      : name = jsonMap['name'] as String,
        tagCategory = jsonMap['tagCategory'] as String,
        displayName = jsonMap['displayName'] as String,
        parentName = (jsonMap['parent'] != null)
            ? (jsonMap['parent'] as Map<String, dynamic>?).toString()
            : (jsonMap['parentName'] != null)
                ? jsonMap["parentName"] as String?
                : null;

  TagModel.fromDomain(Tag tag)
      : name = tag.name,
        tagCategory = tag.tagCategory,
        displayName = tag.displayName,
        parentName = tag.parentName;

  @override
  Map<String, String?> toJson() {
    return {
      "name": name,
      "tagCategory": tagCategory,
      "displayName": displayName,
      "parentName": parentName,
    };
  }

  @override
  Tag toDomain() {
    return Tag(
      name: name,
      tagCategory: tagCategory,
      displayName: displayName,
      parentName: parentName,
    );
  }
}
