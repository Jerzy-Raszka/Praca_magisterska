import 'package:flutter/material.dart';
import 'dishes_app_bar.dart';
import 'dishes_drawer.dart';
import 'dishes_list.dart';

class RecommendedDishes extends StatelessWidget {
  const RecommendedDishes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 245, 228),
      appBar: DishesAppBar(title: 'Polecane potrawy', appBar: AppBar()),
      drawer: DishesDrawer(),
      body: DishesList(deleteOperation: false),
    );
  }
}
