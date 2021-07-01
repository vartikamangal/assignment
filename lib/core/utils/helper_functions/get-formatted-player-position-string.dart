String getFormattedPlayerPosition(Duration duration) {
  return "${duration.inMinutes < 10 ? "0${duration.inMinutes}" : "${duration.inMinutes}"}${":${duration.inSeconds - duration.inMinutes * 60 < 10 ? "0${duration.inSeconds - duration.inMinutes * 60}" : "${duration.inSeconds - duration.inMinutes * 60}"}"}";
}
