import '../../domain/entities/event_details.dart';
import '../../domain/entities/rsvp_status.dart';
import '../../domain/entities/rsvp_summary.dart';
import '../../domain/repositories/invitation_repository.dart';
import '../../../../core/config/supabase_config.dart';
import '../datasources/local_invitation_data_source.dart';
import '../datasources/remote_invitation_data_source.dart';
import '../models/event_details_model.dart';

class InvitationRepositoryImpl implements InvitationRepository {
  InvitationRepositoryImpl({
    required LocalInvitationDataSource localDataSource,
    required RemoteInvitationDataSource remoteDataSource,
  }) : _localDataSource = localDataSource,
       _remoteDataSource = remoteDataSource;

  final LocalInvitationDataSource _localDataSource;
  final RemoteInvitationDataSource _remoteDataSource;

  @override
  EventDetails getEventDetails() {
    return EventDetailsModel.sample();
  }

  @override
  List<String> getGalleryImages() {
    return const [
      'assets/images/one.jpeg',
      'assets/images/two.jpeg',
      'assets/images/three.jpeg',
      'assets/images/four.jpeg',
    ];
  }

  @override
  String getCoupleHeroImage() {
    return 'assets/images/VENU.jpeg';
  }

  @override
  Future<RsvpStatus> getSavedRsvp() async {
    var value = await _localDataSource.getSavedRsvp();

    try {
      final guestKey = await _localDataSource.getOrCreateGuestKey();
      final remoteValue = await _remoteDataSource.getSavedRsvp(guestKey);
      if (remoteValue != null) {
        value = remoteValue;
        await _localDataSource.saveRsvp(remoteValue);
      }
    } catch (_) {
      // Fallback to local cached state when Supabase is not configured.
    }

    return switch (value) {
      'attending' => RsvpStatus.attending,
      'not_attending' => RsvpStatus.notAttending,
      _ => RsvpStatus.unknown,
    };
  }

  @override
  Future<RsvpSummary> getRsvpSummary() async {
    try {
      return await _remoteDataSource.getRsvpSummary();
    } catch (_) {
      if (SupabaseConfig.isConfigured) {
        rethrow;
      }

      final history = await _localDataSource.getRsvpHistory();
      var attendingCount = 0;
      var notAttendingCount = 0;

      for (final response in history) {
        switch (response) {
          case 'attending':
            attendingCount++;
            break;
          case 'not_attending':
            notAttendingCount++;
            break;
        }
      }

      return RsvpSummary(
        attendingCount: attendingCount,
        notAttendingCount: notAttendingCount,
      );
    }
  }

  @override
  Future<void> saveRsvp(RsvpStatus status) async {
    final value = switch (status) {
      RsvpStatus.attending => 'attending',
      RsvpStatus.notAttending => 'not_attending',
      RsvpStatus.unknown => 'unknown',
    };

    await _localDataSource.saveRsvp(value);

    try {
      final guestKey = await _localDataSource.getOrCreateGuestKey();
      await _remoteDataSource.saveRsvp(guestKey: guestKey, status: value);
    } catch (_) {
      if (SupabaseConfig.isConfigured) {
        rethrow;
      }

      // Local fallback still keeps RSVP saved on this device.
    }
  }
}
