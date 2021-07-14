import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/features/view-all-content/data/models/data-model.dart';
import 'package:tatsam_app_experimental/features/view-all-content/data/models/page-model.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/entity.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/page-request.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/page.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/sort-request.dart';

class TestEntity extends Entity {
  final int f1;
  final String f2;

  TestEntity(this.f1, this.f2);
}

class TestModel extends DataModel<TestEntity> {
  int f1;
  String f2;

  TestModel.fromDomain(TestEntity ent)
      : f1 = ent.f1,
        f2 = ent.f2;

  TestModel.fromJson(Map<String, dynamic> jsonMap)
      : f1 = jsonMap["f1"] as int,
        f2 = jsonMap["f2"] as String;

  @override
  TestEntity toDomain() {
    return TestEntity(f1, f2);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "f1": f1,
      "f2": f2,
    };
  }
}

void main() {
  final e1 = TestEntity(1, "1");
  final e2 = TestEntity(2, "2");
  final e3 = TestEntity(3, "3");

  final currentSort = SortRequest(unsorted: true, sorted: false, empty: true);

  final page = Page<TestEntity>(
    content: [e1, e2, e3],
    currentPage: PageRequest(
        sort: currentSort,
        offset: 0,
        pageNumber: 0,
        pageSize: 5,
        paged: true,
        unpaged: false),
    totalPages: 1,
    totalElements: 3,
    numberOfElements: 3,
    number: 0,
    size: 3,
    last: true,
    first: true,
    empty: false,
    currentSort: currentSort,
  );

  test('pagination classes working', () async {
    // "e as TestEntity" shows code is susceptible to runtime typcasting errors
    final pageModel =
        PageModel.fromDomain(page, (TestEntity e) => TestModel.fromDomain(e));
    final p = pageModel.toDomain();
    final j = pageModel.toJson();
    final pm = PageModel.fromJson(j, (e) => TestModel.fromJson(e));
  });
}
