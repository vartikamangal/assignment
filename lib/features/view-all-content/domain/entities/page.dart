import 'entity.dart';
import 'page-request.dart';
import 'sort-request.dart';

class Page<T extends Entity> extends Entity {
  final List<T> content;
  final PageRequest currentPage;
  final int totalPages;
  final int totalElements;
  final int numberOfElements;
  final int number;
  final int size;
  final bool last;
  final bool first;
  final bool empty;
  final SortRequest currentSort;

  Page({
    required this.content,
    required this.currentPage,
    required this.totalPages,
    required this.totalElements,
    required this.numberOfElements,
    required this.number,
    required this.size,
    required this.last,
    required this.first,
    required this.empty,
    required this.currentSort,
  });
}
