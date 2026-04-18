import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LocalInvitationDataSource {
  const LocalInvitationDataSource();

  static const String rsvpKey = 'rsvp_status';
  static const String rsvpHistoryKey = 'rsvp_history';
  static const String guestKey = 'guest_key';

  Future<String?> getSavedRsvp() async {
    throw UnimplementedError();
  }

  Future<List<String>> getRsvpHistory() async {
    throw UnimplementedError();
  }

  Future<String> getOrCreateGuestKey() async {
    throw UnimplementedError();
  }

  Future<void> saveRsvp(String status) async {
    throw UnimplementedError();
  }
}

class LocalInvitationDataSourceImpl extends LocalInvitationDataSource {
  const LocalInvitationDataSourceImpl();

  static const Uuid _uuid = Uuid();

  @override
  Future<String?> getSavedRsvp() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final history = prefs.getStringList(
        LocalInvitationDataSource.rsvpHistoryKey,
      );
      if (history != null && history.isNotEmpty) {
        return history.last;
      }

      return prefs.getString(LocalInvitationDataSource.rsvpKey);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<String>> getRsvpHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(LocalInvitationDataSource.rsvpHistoryKey) ??
          <String>[];
    } catch (_) {
      return <String>[];
    }
  }

  @override
  Future<String> getOrCreateGuestKey() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(LocalInvitationDataSource.guestKey);
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }

    final generated = _uuid.v4();
    final saved = await prefs.setString(LocalInvitationDataSource.guestKey, generated);
    if (!saved) {
      throw Exception('Unable to persist guest key.');
    }

    return generated;
  }

  @override
  Future<void> saveRsvp(String status) async {
    final prefs = await SharedPreferences.getInstance();
    final currentHistory =
        prefs.getStringList(LocalInvitationDataSource.rsvpHistoryKey) ??
        <String>[];
    currentHistory.add(status);

    final savedHistory = await prefs.setStringList(
      LocalInvitationDataSource.rsvpHistoryKey,
      currentHistory,
    );
    final saved = await prefs.setString(
      LocalInvitationDataSource.rsvpKey,
      status,
    );
    if (!savedHistory || !saved) {
      throw Exception('Unable to save RSVP response.');
    }
  }
}
