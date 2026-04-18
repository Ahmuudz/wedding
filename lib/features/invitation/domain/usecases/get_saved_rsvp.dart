import '../entities/rsvp_status.dart';
import '../repositories/invitation_repository.dart';

class GetSavedRsvp {
  const GetSavedRsvp(this._repository);

  final InvitationRepository _repository;

  Future<RsvpStatus> call() {
    return _repository.getSavedRsvp();
  }
}
