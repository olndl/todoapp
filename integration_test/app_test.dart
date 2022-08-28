// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// import 'package:integration_test/integration_test.dart';
//
// import 'package:todoapp/main.dart' as app;
//
// void main() {
//
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//
//   group('end-to-end test', () {
//
//     testWidgets('tap on the floating action button, verify counter',
//
//             (WidgetTester tester) async {
//
//           app.main();
//
//           await tester.pumpAndSettle();
//
//           // Verifies that the counter starts at 0.
//
//           expect(find.byIcon(IconData(SvgPicture.asset(S.iconVisibility))), findsOneWidget);
//
//           // Finds the floating action button to tap on.
//
//           final Finder fab = find.byKey(ValueKey('eye'));
//
//           // Emulates a tap on the floating action button.
//
//           await tester.tap(fab);
//
//           // Triggers a frame.
//
//           await tester.pumpAndSettle();
//
//           // Verifies if the counter increments by 1.
//
//           expect(find.byIcon(SvgPicture.asset(S.iconVisibility))), findsOneWidget);
//
//         });
//
//   });
//
// }
