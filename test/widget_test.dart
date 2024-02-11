// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:dartros/dartros.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ros_examples/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  test("rosmaster connection", () async {
    NodeHandle nh = await initNode(
      'ros_node_1', List<String>.empty(),
     rosMasterUri: "http://docker.for.mac.localhost:11311",
      // rosIP: InternetAddress("docker.for.mac.localhost", type: InternetAddressType.IPv4),
    );
    await nh.getMasterUri();
    await nh.setParam('/foo', 'value');
    var value = await nh.getParam('/foo');
    assert(value == 'value');
    print(value);

    print(await nh.setParam('/foo', 'new value'));
    value = await nh.getParam('/foo');
    assert(value == 'new value');
    print(value);
  });
}
