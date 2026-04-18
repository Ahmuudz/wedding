class EventDetails {
  const EventDetails({
    required this.dateLabel,
    required this.timeLabel,
    required this.locationName,
    required this.locationAddress,
    required this.mapsUrl,
    required this.latitude,
    required this.longitude,
    required this.weddingDateTime,
  });

  final String dateLabel;
  final String timeLabel;
  final String locationName;
  final String locationAddress;
  final String mapsUrl;
  final double latitude;
  final double longitude;
  final DateTime weddingDateTime;
}
