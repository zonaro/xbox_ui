import 'package:flutter_test/flutter_test.dart';
import 'package:xbox_ui/xbox_mock.dart';

void main() {
  testWidgets('Test XBOX UI', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(const XboxMock());
  });
}

