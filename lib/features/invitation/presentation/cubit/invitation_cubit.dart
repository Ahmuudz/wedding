import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/rsvp_status.dart';
import '../../domain/usecases/get_invitation_content.dart';
import '../../domain/usecases/get_rsvp_summary.dart';
import '../../domain/usecases/get_saved_rsvp.dart';
import '../../domain/usecases/save_rsvp.dart';
import 'invitation_state.dart';

class InvitationCubit extends Cubit<InvitationState> {
  InvitationCubit({
    required GetInvitationContent getInvitationContent,
    required GetSavedRsvp getSavedRsvp,
    required GetRsvpSummary getRsvpSummary,
    required SaveRsvp saveRsvp,
  }) : _getSavedRsvp = getSavedRsvp,
       _getRsvpSummary = getRsvpSummary,
       _saveRsvp = saveRsvp,
       super(
         InvitationState(
           eventDetails: getInvitationContent.getEventDetails(),
           galleryImages: getInvitationContent.getGalleryImages(),
           heroImage: getInvitationContent.getCoupleHeroImage(),
         ),
       );

  final GetSavedRsvp _getSavedRsvp;
  final GetRsvpSummary _getRsvpSummary;
  final SaveRsvp _saveRsvp;

  Future<void> loadSavedRsvp() async {
    try {
      final saved = await _getSavedRsvp();
      final summary = await _getRsvpSummary();
      emit(
        state.copyWith(
          rsvpStatus: saved,
          attendingCount: summary.attendingCount,
          notAttendingCount: summary.notAttendingCount,
          clearError: true,
        ),
      );
    } catch (_) {
      emit(state.copyWith(errorMessage: 'Failed to load RSVP status.'));
    }
  }

  Future<void> submitRsvp(RsvpStatus status) async {
    if (status == state.rsvpStatus) {
      emit(
        state.copyWith(
          clearError: true,
          clearSnackBar: true,
          snackBarMessage: 'You already selected this response.',
        ),
      );
      return;
    }

    emit(state.copyWith(isSaving: true, clearError: true, clearSnackBar: true));

    try {
      await _saveRsvp(status);
      final summary = await _getRsvpSummary();
      final message = status == RsvpStatus.attending
          ? 'Thank you! We are excited to celebrate with you.'
          : 'Your response has been saved with love.';
      emit(
        state.copyWith(
          rsvpStatus: status,
          attendingCount: summary.attendingCount,
          notAttendingCount: summary.notAttendingCount,
          isSaving: false,
          snackBarMessage: message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isSaving: false,
          errorMessage: 'Could not save your RSVP. Please try again.',
          snackBarMessage: 'Could not save your RSVP. Please try again.',
        ),
      );
    }
  }

  void clearSnackBarMessage() {
    emit(state.copyWith(clearSnackBar: true));
  }
}
