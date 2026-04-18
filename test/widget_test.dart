import 'package:flutter_test/flutter_test.dart';

import 'package:wedding_invitation_app/app.dart';

void main() {
  testWidgets('shows welcome invitation content', (WidgetTester tester) async {
    await tester.pumpWidget(const WeddingInvitationApp());
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.textContaining('You are invited to celebrate'), findsOneWidget);
    expect(find.text('View Invitation'), findsOneWidget);
  });
}
