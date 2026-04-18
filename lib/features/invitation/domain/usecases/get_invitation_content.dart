import '../entities/event_details.dart';
import '../repositories/invitation_repository.dart';

class GetInvitationContent {
  const GetInvitationContent(this._repository);

  final InvitationRepository _repository;

  EventDetails getEventDetails() {
    return _repository.getEventDetails();
  }

  List<String> getGalleryImages() {
    return _repository.getGalleryImages();
  }

  String getCoupleHeroImage() {
    return _repository.getCoupleHeroImage();
  }
}
