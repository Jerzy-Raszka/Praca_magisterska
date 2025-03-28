import 'package:flutter/material.dart';
import 'package:frontend/components/dishes_allergen.dart';

class DishesPreferences extends StatefulWidget {
  const DishesPreferences({super.key});

  @override
  State<StatefulWidget> createState() => _DishesPreference();
}

//TODO: add drop-down list with diets to choose and saving data
class _DishesPreference extends State<DishesPreferences> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Wrap(
            children: [
              //TODO: Add event listener that change value of allergen adn do for all 9
              DishesAlergen(allergen: false, allergenName: 'marchewka'),
            ],
          ),
        ],
      ),
    );
  }
}
