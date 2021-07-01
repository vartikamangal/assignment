/// for calculating postiion for the progress bar
double calculatePosition(Duration currentPos, Duration maxPos) {
  return (currentPos.inMilliseconds / maxPos.inMilliseconds)
      .clamp(0, 1)
      .toDouble();
}
