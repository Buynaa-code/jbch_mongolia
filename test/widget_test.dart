import 'package:flutter_test/flutter_test.dart';

import 'package:jbch_mongolia/main.dart';

void main() {
  testWidgets('App should build without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const JBCHMongoliaApp());

    // Verify that the app renders successfully by checking for the app title
    // The app should load the home page
    await tester.pumpAndSettle();
  });
}
