import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/rsvp_summary.dart';

class RemoteInvitationDataSource {
  const RemoteInvitationDataSource();

  static const String table = 'rsvps';

  Future<String?> getSavedRsvp(String guestKey) async {
    final response = await Supabase.instance.client
        .from(table)
        .select('status')
        .eq('guest_key', guestKey)
        .maybeSingle();

    return response?['status'] as String?;
  }

  Future<void> saveRsvp({required String guestKey, required String status}) async {
    await Supabase.instance.client.from(table).upsert(
      {
        'guest_key': guestKey,
        'status': status,
        'updated_at': DateTime.now().toIso8601String(),
      },
      onConflict: 'guest_key',
    );
  }

  Future<RsvpSummary> getRsvpSummary() async {
    final response = await Supabase.instance.client.from(table).select('status');
    final rows = List<Map<String, dynamic>>.from(response);

    var attendingCount = 0;
    var notAttendingCount = 0;

    for (final row in rows) {
      final status = row['status'] as String?;
      if (status == 'attending') {
        attendingCount++;
      } else if (status == 'not_attending') {
        notAttendingCount++;
      }
    }

    return RsvpSummary(
      attendingCount: attendingCount,
      notAttendingCount: notAttendingCount,
    );
  }
}
