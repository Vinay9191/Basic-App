import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/main.dart';

void main() {
  test('greetingFor maps hours to the right message', () {
    expect(greetingFor(DateTime(2026, 9, 21, 7)).heading, 'Good morning!');
    expect(greetingFor(DateTime(2026, 9, 21, 14)).heading, 'Good afternoon!');
    expect(greetingFor(DateTime(2026, 9, 21, 19)).heading, 'Good evening!');
    expect(greetingFor(DateTime(2026, 9, 21, 23)).heading, 'Good night!');
    expect(greetingFor(DateTime(2026, 9, 21, 2)).heading, 'Good night!');
  });

  testWidgets('Shows a time-based greeting and waving hand', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(now: DateTime(2026, 9, 21, 10)));

    expect(find.text('Good morning!'), findsOneWidget);
    expect(find.text('Have a wonderful day!'), findsOneWidget);
    expect(find.text('\u{1F44B}'), findsOneWidget);

    await tester.pumpWidget(MyApp(now: DateTime(2026, 9, 21, 15)));
    expect(find.text('Good afternoon!'), findsOneWidget);

    await tester.pumpWidget(MyApp(now: DateTime(2026, 9, 21, 18)));
    expect(find.text('Good evening!'), findsOneWidget);

    await tester.pumpWidget(MyApp(now: DateTime(2026, 9, 21, 22)));
    expect(find.text('Good night!'), findsOneWidget);
  });
}
