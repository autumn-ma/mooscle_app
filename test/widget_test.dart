import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mooscle_app/main.dart';

void main() {
  testWidgets('add todo item', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // open add dialog
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // enter text
    await tester.enterText(find.byType(TextField), 'Test todo');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    // verify new todo is shown
    expect(find.text('Test todo'), findsOneWidget);
  });
}
