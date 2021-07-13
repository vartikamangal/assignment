// ignore: constant_identifier_names
const BASE_URL = "https://api.dev.tatsam.in";

extension MakeUrl on String {
  String makeUrl() => "$BASE_URL$this";
}
