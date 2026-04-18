import '../../domain/entities/event_details.dart';

class EventDetailsModel extends EventDetails {
  const EventDetailsModel({
    required super.dateLabel,
    required super.timeLabel,
    required super.locationName,
    required super.locationAddress,
    required super.mapsUrl,
    required super.latitude,
    required super.longitude,
    required super.weddingDateTime,
  });

  factory EventDetailsModel.sample() {
    return EventDetailsModel(
      dateLabel: 'Saturday, 11 July 2026',
      timeLabel: '06:00 PM',
      locationName: 'Vow Orabi',
      locationAddress: 'Vow Orabi',
      mapsUrl: 'https://maps.app.goo.gl/oStsXYAqKSUaiPsF7?g_st=ic',
      latitude: 30.0595,
      longitude: 31.2578,
      weddingDateTime: DateTime(2026, 7, 11, 18, 0),
    );
  }
}
