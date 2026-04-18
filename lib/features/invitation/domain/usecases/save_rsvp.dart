import '../entities/rsvp_status.dart';
import '../repositories/invitation_repository.dart';

class SaveRsvp {
  const SaveRsvp(this._repository);

  final InvitationRepository _repository;

  Future<void> call(RsvpStatus status) {
    return _repository.saveRsvp(status);
  }
}
