// Flutter imports:

// Project imports:
import '../../domain/entities/tag.dart';

class TagModel extends Tag {
  const TagModel({
    required String? name,
    required String? tagCategory,
    required String? displayName,
    required String? parentName,
  }) : super(
          displayName: displayName,
          tagCategory: tagCategory,
          parentName: parentName,
          name: name,
        );

  factory TagModel.fromJson(Map<String, dynamic> jsonMap) {
    return TagModel(
      name: jsonMap['name'] as String?,
      tagCategory: jsonMap['tagCategory'] as String?,
      displayName: jsonMap['displayName'] as String?,
      //Dure to change in model names of SELF AND GUIDED
      parentName: (jsonMap['parent'] != null)
          // Just jsonEncode() if you need i =t in near future
          // Or simplt tweak the TagModel a little bit
          ? (jsonMap['parent'] as Map<String, dynamic>?).toString()
          : (jsonMap['parentName'] != null)
              ? jsonMap["parentName"] as String?
              : null,
    );
  }

  Map<String, String?> toJson() {
    return {
      "name": name,
      "tagCategory": tagCategory,
      "displayName": displayName,
      "parentName": parentName,
    };
  }
}
