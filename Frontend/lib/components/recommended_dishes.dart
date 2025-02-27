import 'package:flutter/material.dart';
import 'package:frontend/components/dishes_app_bar.dart';
import 'package:frontend/components/dishes_drawer.dart';

class RecommendedDishes extends StatelessWidget {
  const RecommendedDishes({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 245, 228),
      appBar: DishesAppBar(title: 'Polecane dania', appBar: AppBar()),
      drawer: DishesDrawer(),
      body: Text('kappa'), //TODO: body: widget builder
    );
  }
}
