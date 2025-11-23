import 'package:flutter/material.dart';
import 'components/recommended_dishes.dart';
import 'components/dishes_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final diet = prefs.getString('diet');
  final hasAllergens = prefs.getKeys().any(
    (key) => key.endsWith('AlergStatus') && prefs.getBool(key) == true,
  );

  runApp(MyApp(showPreferences: diet == null || diet.isEmpty || !hasAllergens));
}

class MyApp extends StatelessWidget {
  final bool showPreferences;
  const MyApp({super.key, required this.showPreferences});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          showPreferences
              ? const DishesPreferences()
              : const RecommendedDishes(),
    );
  }
}
