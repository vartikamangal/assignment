import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/page-request.dart';

import 'data-model.dart';
import 'sort-request-model.dart';

class PageRequestModel extends DataModel<PageRequest> {
  SortRequestModel sort;
  int offset;
  int pageNumber;
  int pageSize;
  bool paged;
  bool unpaged;

  PageRequestModel.fromDomain(PageRequest pageRequest) :
        sort = SortRequestModel.fromDomain(pageRequest.sort),
        offset = pageRequest.offset,
        pageNumber = pageRequest.pageNumber,
        pageSize = pageRequest.pageSize,
        paged = pageRequest.paged,
        unpaged = pageRequest.unpaged;

  PageRequestModel.fromJson(Map<String, dynamic> jsonMap) :
        sort = SortRequestModel.fromJson(
            jsonMap["sort"] as Map<String, dynamic>),
        offset = jsonMap["offset"] as int,
        pageNumber = jsonMap["pageNumber"] as int,
        pageSize = jsonMap["pageSize"] as int,
        paged = jsonMap["paged"] as bool,
        unpaged = jsonMap["unpaged"] as bool;

  @override
  Map<String, dynamic> toJson() {
    return {
      "sort" : sort.toJson(),
      "offset" : offset,
      "pageNumber" : pageNumber,
      "pageSize" : pageSize,
      "paged" : paged,
      "unpaged" : unpaged,
    };
  }

  @override
  PageRequest toDomain() {
    return PageRequest(
        sort: sort.toDomain(),
        offset: offset,
        pageNumber: pageNumber,
        pageSize: pageSize,
        paged: paged,
        unpaged: unpaged,
    );
  }

}