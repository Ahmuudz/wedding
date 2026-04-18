import '../entities/rsvp_summary.dart';
import '../repositories/invitation_repository.dart';

class GetRsvpSummary {
  const GetRsvpSummary(this._repository);

  final InvitationRepository _repository;

  Future<RsvpSummary> call() {
    return _repository.getRsvpSummary();
  }
}
