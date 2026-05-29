import 'package:flutter_test/flutter_test.dart';

import 'package:liji_tea/main.dart';

void main() {
  testWidgets('Home screen renders brand and featured product', (tester) async {
    await tester.pumpWidget(const LijiTeaApp());
    await tester.pump();

    expect(find.text('LIJI·TEA'), findsOneWidget);
    expect(find.text('今日推荐'), findsOneWidget);
    expect(find.text('明前龙井'), findsOneWidget);
  });

  testWidgets('Bottom navigation switches tabs', (tester) async {
    await tester.pumpWidget(const LijiTeaApp());
    await tester.pump();

    await tester.tap(find.text('我的'));
    await tester.pump();

    expect(find.text('敬请期待'), findsOneWidget);
  });
}
