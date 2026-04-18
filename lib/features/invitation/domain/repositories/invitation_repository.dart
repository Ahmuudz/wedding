import '../entities/event_details.dart';
import '../entities/rsvp_status.dart';
import '../entities/rsvp_summary.dart';

abstract class InvitationRepository {
  EventDetails getEventDetails();

  List<String> getGalleryImages();

  String getCoupleHeroImage();

  Future<RsvpStatus> getSavedRsvp();

  Future<RsvpSummary> getRsvpSummary();

  Future<void> saveRsvp(RsvpStatus status);
}
