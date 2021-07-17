import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/tag.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/tag-model.dart';
import 'package:tatsam_app_experimental/features/view-all-content/data/models/data-model.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/entity.dart';
import '../../../../fixtures/fixture-reader.dart';

class TagEntity extends Entity {
  final String name;
  final String tagCategory;
  final String displayName;
  final String parentName;
  TagEntity(this.name, this.tagCategory, this.displayName, this.parentName);
}

class TagModel extends DataModel<TagEntity> {
  String name;
  String tagCategory;
  String displayName;
  String parentName;
  TagModel.fromDomain(TagEntity ent)
      : name = ent.name,
        displayName = ent.displayName,
        tagCategory = ent.tagCategory,
        parentName = ent.parentName;
  TagModel.fromJson(Map<String, dynamic> jsonMap)
      : name = jsonMap["name"] as String,
        displayName = jsonMap["displayName"] as String,
        tagCategory = jsonMap["tagCategory"] as String,
        parentName = jsonMap["parentName"] as String;
  @override
  TagEntity toDomain() {
    return TagEntity(name, tagCategory, displayName, parentName);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "displayName": displayName,
      "tagCategory": tagCategory,
      "parentName": parentName
    };
  }
}

void main() {
  final Tags = TagEntity("name", "tagCategory", "displayName", "parentName");
  test('pagination classes working', () async {
    // "e as TestEntity" shows code is susceptible to runtime typcasting errors
    final tTagModel = TagModel.fromDomain(Tags);
    final p = tTagModel.toDomain();
    final j = tTagModel.toJson();
    final pm = TagModel.fromJson(j);
  });
}
