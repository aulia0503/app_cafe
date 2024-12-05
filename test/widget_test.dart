import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:a_1/screens/home_screen.dart';
import 'package:a_1/screens/coffee_list_screen.dart';
import 'package:a_1/models/coffee.dart';
import 'package:a_1/services/coffee_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  testWidgets('Home screen displays coffee categories',
      (WidgetTester tester) async {
    // Build HomeScreen directly for testing.
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Verify the presence of category items.
    expect(find.text('Hot Coffee'), findsOneWidget);
    expect(find.text('Iced Coffee'), findsOneWidget);
  });

  testWidgets('Navigates to coffee list screen on category tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Tap on 'Hot Coffee' category.
    await tester.tap(find.text('Hot Coffee'));
    await tester.pumpAndSettle();

    // Verify we navigated to the CoffeeListScreen for 'Hot Coffee'.
    expect(find.text('Hot Coffee'), findsOneWidget);
  });

  testWidgets('Displays coffee details when coffee item is tapped',
      (WidgetTester tester) async {
    // Fetch hot coffees data
    final response =
        await http.get(Uri.parse('https://api.sampleapis.com/coffee/hot'));
    final List<dynamic> data = json.decode(response.body);
    final List<Coffee> hotCoffees =
        data.map((json) => Coffee.fromJson(json)).toList();

    // Build HomeScreen directly for testing.
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Navigate to CoffeeListScreen by tapping 'Hot Coffee' category.
    await tester.tap(find.text('Hot Coffee'));
    await tester.pumpAndSettle();

    // Ensure that the list of coffee items is displayed.
    for (var coffee in hotCoffees) {
      expect(find.text(coffee.title), findsOneWidget);
    }

    // Simulate tapping on a coffee item.
    await tester.tap(find.text(hotCoffees.first.title));
    await tester.pumpAndSettle();

    // Verify coffee details screen shows correct details.
    expect(find.text(hotCoffees.first.title), findsOneWidget);
    expect(find.textContaining('Ingredients'), findsOneWidget);
  });
}
