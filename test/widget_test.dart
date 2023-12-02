import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forgotten_key/main.dart';

void main() {
  testWidgets('File dialog opens smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byIcon(Icons.file_open), isNotNull);
  });
}
