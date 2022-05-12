// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:coresystem/main.dart';
import 'package:coresystem/Utils/Crypto/cryptojs_aes_encryption_helper.dart';
import 'package:intl/intl.dart';
void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // // Build our app and trigger a frame.
    // await tester.pumpWidget(MyApp());

    // // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);

    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
    print('fffffffff');
    var a = encryptAESCryptoJS("Abc@123", "C02PASSWORDCMN");
    //U2FsdGVkX18gcme/N1HVz0GizEoyrZn6NS3Vi/gAAGg=
    print(a);

      final startDate = DateFormat('dd/MM/yyyy').parse('01/01/2022');

      final b= startDate.add(Duration(days: 50));
      final endDate = DateFormat('dd/MM/yyyy').parse('02/02/2022');
      print(b.difference(startDate).inDays);

// UserDA.login('admin','123456');
//     var b = BaseItem();
//       var c = BaseItem();
//     var lst = [b,c];
  });
}
