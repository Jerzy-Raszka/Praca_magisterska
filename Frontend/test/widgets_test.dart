import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/components/recommended_dishes.dart';
import 'package:frontend/components/dishes_list.dart';
import 'package:frontend/models/dish.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('UI integration tests', () {
    testWidgets('RecommendedDishes renders without errors', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: RecommendedDishes()));
      await tester.pumpAndSettle();

      // AppBar title should be present
      expect(find.text('Polecane potrawy'), findsOneWidget);
    });
    testWidgets('Drawer opens and shows menu entries', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: RecommendedDishes()));

      final Finder openDrawer = find.byTooltip('Open navigation menu');
      expect(openDrawer, findsOneWidget);
      await tester.tap(openDrawer);
      await tester.pumpAndSettle();
      expect(find.text('Menu'), findsOneWidget);
      expect(find.text('Polecane potrawy'), findsWidgets);
      expect(find.text('Zapisane potrawy'), findsWidgets);
      expect(find.text('Zmień preferencje'), findsWidgets);
      expect(find.text('Usuń zapisane dane'), findsWidgets);
    });

    testWidgets('Navigation from drawer to LikedDishes screen', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: RecommendedDishes()));
      final Finder openDrawer = find.byTooltip('Open navigation menu');
      await tester.tap(openDrawer);
      await tester.pumpAndSettle();
      final Finder likedItemCard =
          find
              .ancestor(
                of: find.text('Zapisane potrawy'),
                matching: find.byType(GestureDetector),
              )
              .first;
      await tester.tap(likedItemCard);
      await tester.pumpAndSettle();
      expect(find.text('Polubione potrawy'), findsOneWidget);
    });

    testWidgets('DishesList displays provided initial data', (
      WidgetTester tester,
    ) async {
      final sample = Dish(
        id: '1',
        name: 'Test dish',
        porkTag: false,
        beefTag: false,
        chickenTag: true,
        eggTag: false,
        fishTag: false,
        shellfishTag: false,
        tofuTag: false,
        pastaTag: false,
        riceTag: false,
        groatsTag: false,
        soupTag: false,
        saladTag: false,
        vegetablesTag: false,
        chesseTag: false,
        fruitTag: false,
        pictureUrl: '',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DishesList(deleteOperation: false, initialData: [sample]),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Test dish'), findsOneWidget);
      expect(find.byType(GestureDetector), findsWidgets);
    });
  });
}
