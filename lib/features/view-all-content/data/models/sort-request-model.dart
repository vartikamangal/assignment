import 'package:tatsam_app_experimental/features/view-all-content/data/models/data-model.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/sort-request.dart';

class SortRequestModel extends DataModel<SortRequest> {
  bool unsorted;
  bool sorted;
  bool empty;

  SortRequestModel.fromDomain(SortRequest sortRequest)
      : unsorted = sortRequest.unsorted,
        sorted = sortRequest.sorted,
        empty = sortRequest.empty;

  SortRequestModel.fromJson(Map<String, dynamic> jsonMap)
      : unsorted = jsonMap["unsorted"] as bool,
        sorted = jsonMap["sorted"] as bool,
        empty = jsonMap["empty"] as bool;

  @override
  Map<String, dynamic> toJson() {
    return {
      "unsorted": unsorted,
      "sorted": sorted,
      "empty": empty,
    };
  }

  @override
  SortRequest toDomain() {
    return SortRequest(unsorted: unsorted, sorted: sorted, empty: empty);
  }
}
