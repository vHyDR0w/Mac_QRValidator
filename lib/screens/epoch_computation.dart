class EpochComputation {
  // final String createddateString;
  final int year;
  final int month;
  final int day;
  // final int createdEpochTimeMillis;
  final int epochTimeMin;

  EpochComputation(this.year, this.month, this.day, this.epochTimeMin);
}

EpochComputation computefunction(String createddateString) {
  DateTime createddateTime = DateTime.parse(createddateString);
  int year = createddateTime.year;
  int month = createddateTime.month;
  int day = createddateTime.day;
  int createdEpochTimeMillis = createddateTime.millisecondsSinceEpoch;

  final now = DateTime.now();
  int currEpochTimeMillis = now.millisecondsSinceEpoch;
  int epochTimeMin = (currEpochTimeMillis - createdEpochTimeMillis) ~/ 60000;

  return EpochComputation(year, month, day, epochTimeMin);
}
