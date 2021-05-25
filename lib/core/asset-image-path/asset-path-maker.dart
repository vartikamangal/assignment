const AssetFolder="assets";

extension MakePath on String {
  String makePath() => "$AssetFolder$this";
}