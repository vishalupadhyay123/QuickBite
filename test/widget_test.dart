import 'package:flutter_test/flutter_test.dart';
import 'package:studymate/main.dart';

void main() {
  testWidgets('QuickBite app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const QuickBiteApp());
    expect(find.byType(QuickBiteApp), findsOneWidget);
  });
}
