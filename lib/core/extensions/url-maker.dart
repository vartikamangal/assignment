// ignore: constant_identifier_names
const BASE_URL = "http://13.229.249.25:9090";

extension MakeUrl on String {
  String makeUrl() => "$BASE_URL$this";
}
