import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/entity.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/page.dart';

import 'data-model.dart';
import 'page-request-model.dart';
import 'sort-request-model.dart';

class PageModel<T extends DataModel<E>, E extends Entity>
    implements DataModel<Page<E>> {
  List<T> content;
  PageRequestModel currentPage;
  int totalPages;
  int totalElements;
  int numberOfElements;
  int number;
  int size;
  bool last;
  bool first;
  bool empty;
  SortRequestModel currentSort;

  PageModel.fromDomain(Page<E> page, T Function(E) entityToModelMapper)
      : content = page.content.map((e) => entityToModelMapper(e)).toList(),
        currentPage = PageRequestModel.fromDomain(page.currentPage),
        totalPages = page.totalPages,
        totalElements = page.totalElements,
        numberOfElements = page.numberOfElements,
        number = page.number,
        size = page.size,
        last = page.last,
        first = page.first,
        empty = page.empty,
        currentSort = SortRequestModel.fromDomain(page.currentSort);

  PageModel.fromJson(
    Map<String, dynamic> jsonMap,
    T Function(Map<String, dynamic>) jsonToModelMapper,
  )   : content = (jsonMap["content"].toList() as List)
            .map((e) => jsonToModelMapper(e as Map<String, dynamic>))
            .toList(),
        currentPage = PageRequestModel.fromJson(
            jsonMap["pageable"] as Map<String, dynamic>),
        totalPages = jsonMap["totalPages"] as int,
        totalElements = jsonMap["totalElements"] as int,
        numberOfElements = jsonMap["numberOfElements"] as int,
        number = jsonMap["number"] as int,
        size = jsonMap["size"] as int,
        last = jsonMap["last"] as bool,
        first = jsonMap["first"] as bool,
        empty = jsonMap["empty"] as bool,
        currentSort =
            SortRequestModel.fromJson(jsonMap["sort"] as Map<String, dynamic>);

  @override
  Map<String, dynamic> toJson() {
    return {
      "content": content.map((e) => e.toJson()),
      "pageable": currentPage.toJson(),
      "totalPages": totalPages,
      "totalElements": totalElements,
      "numberOfElements": numberOfElements,
      "number": number,
      "size": size,
      "last": last,
      "first": first,
      "empty": empty,
      "sort": currentSort.toJson(),
    };
  }

  @override
  Page<E> toDomain() {
    return Page(
      content: content.map((e) => e.toDomain()).toList(),
      currentPage: currentPage.toDomain(),
      totalPages: totalPages,
      totalElements: totalElements,
      numberOfElements: numberOfElements,
      number: number,
      size: size,
      last: last,
      first: first,
      empty: empty,
      currentSort: currentSort.toDomain(),
    );
  }
}
