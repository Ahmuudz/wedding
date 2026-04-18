class RsvpSummary {
  const RsvpSummary({
    required this.attendingCount,
    required this.notAttendingCount,
  });

  final int attendingCount;
  final int notAttendingCount;

  int get total => attendingCount + notAttendingCount;
}
