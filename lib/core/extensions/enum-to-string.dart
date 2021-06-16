extension EnumToString on String {
  // ignore: unnecessary_this
  String enumToString() => this.split('.').last;
}
