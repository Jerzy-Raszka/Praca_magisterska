import 'package:flutter/material.dart';

import 'diets_list.dart';
import 'dishes_app_bar.dart';
import 'dishes_drawer.dart';

class DishesPreferences extends StatelessWidget {
  const DishesPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 245, 228),
      appBar: DishesAppBar(title: 'Preferencje', appBar: AppBar()),
      drawer: DishesDrawer(),
      body: DietsList(),
    );
  }
}
