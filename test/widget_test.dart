// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openfred/main.dart';


void main() {
  group('Expense Tracker App Tests', () {
    testWidgets('Initial Widget Rendering Test', (WidgetTester tester) async {
      await tester.pumpWidget(const ExpenseTrackerApp());

      // Verify initial home page is displayed
      expect(find.text('Start A Trail'), findsOneWidget);
    });

    testWidgets('Add Expense Dialog Test', (WidgetTester tester) async {
      await tester.pumpWidget(const ExpenseTrackerApp());

      // Tap the '+' button to open the AddExpenseDialog
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Verify that Add Expense dialog appears
      expect(find.text('Add Expense'), findsOneWidget);

      // Fill in the form and add an expense
      await tester.enterText(find.byType(TextFormField).at(0), 'Test Expense');
      await tester.enterText(find.byType(TextFormField).at(1), '50');
      await tester.tap(find.byType(ListTile)); // Tap on date picker ListTile
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK').last); // Choose a date
      await tester.pumpAndSettle();
      await tester.tap(find.text('Food').last); // Choose a category
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add')); // Tap on Add button
      await tester.pumpAndSettle();

      // Verify that the expense is added to the list
      expect(find.text('Test Expense'), findsOneWidget);
      expect(find.text('50.0'), findsOneWidget);
      expect(find.text('Food'), findsOneWidget);
    });

    testWidgets('Delete Expense Test', (WidgetTester tester) async {
      await tester.pumpWidget(const ExpenseTrackerApp());

      // Add an expense first (using the same approach as Add Expense test)
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).at(0), 'Test Expense');
      await tester.enterText(find.byType(TextFormField).at(1), '50');
      await tester.tap(find.byType(ListTile)); // Tap on date picker ListTile
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK').last); // Choose a date
      await tester.pumpAndSettle();
      await tester.tap(find.text('Food').last); // Choose a category
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add')); // Tap on Add button
      await tester.pumpAndSettle();

      // Verify that the expense is added to the list
      expect(find.byType(ListTile), findsOneWidget);

      // Now, delete the expense
      await tester.tap(find.byIcon(Icons.delete).first); // Tap delete icon of first expense
      await tester.pumpAndSettle();

      // Verify that the expense is deleted from the list
      expect(find.byType(ListTile), findsNothing);
    });

    testWidgets('Navigation Test', (WidgetTester tester) async {
      await tester.pumpWidget(const ExpenseTrackerApp());

      // Verify initial home page is displayed
      expect(find.text('Start A Trail'), findsOneWidget);

      // Navigate to SettingsPage
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      // Verify that SettingsPage is displayed
      expect(find.text('Settings Page'), findsOneWidget);

      // Navigate back to HomePage
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Verify that HomePage is displayed again
      expect(find.text('Start A Trail'), findsOneWidget);
    });
  });
}
