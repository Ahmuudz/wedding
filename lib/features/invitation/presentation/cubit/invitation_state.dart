import '../../domain/entities/event_details.dart';
import '../../domain/entities/rsvp_status.dart';

class InvitationState {
  const InvitationState({
    required this.eventDetails,
    required this.galleryImages,
    required this.heroImage,
    this.rsvpStatus = RsvpStatus.unknown,
    this.attendingCount = 0,
    this.notAttendingCount = 0,
    this.isSaving = false,
    this.errorMessage,
    this.snackBarMessage,
  });

  final EventDetails eventDetails;
  final List<String> galleryImages;
  final String heroImage;
  final RsvpStatus rsvpStatus;
  final int attendingCount;
  final int notAttendingCount;
  final bool isSaving;
  final String? errorMessage;
  final String? snackBarMessage;

  InvitationState copyWith({
    EventDetails? eventDetails,
    List<String>? galleryImages,
    String? heroImage,
    RsvpStatus? rsvpStatus,
    int? attendingCount,
    int? notAttendingCount,
    bool? isSaving,
    String? errorMessage,
    String? snackBarMessage,
    bool clearError = false,
    bool clearSnackBar = false,
  }) {
    return InvitationState(
      eventDetails: eventDetails ?? this.eventDetails,
      galleryImages: galleryImages ?? this.galleryImages,
      heroImage: heroImage ?? this.heroImage,
      rsvpStatus: rsvpStatus ?? this.rsvpStatus,
      attendingCount: attendingCount ?? this.attendingCount,
      notAttendingCount: notAttendingCount ?? this.notAttendingCount,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      snackBarMessage: clearSnackBar
          ? null
          : (snackBarMessage ?? this.snackBarMessage),
    );
  }
}
