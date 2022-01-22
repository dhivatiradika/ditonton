import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should show page when opened', (tester) async {
    final image = find.byType(Image);
    final text = find.byType(Text);
    final iconButton = find.byType(IconButton);

    await tester.pumpWidget(MaterialApp(
      home: AboutPage(),
    ));

    expect(image, findsOneWidget);
    expect(text, findsOneWidget);
    expect(iconButton, findsOneWidget);
  });
}
