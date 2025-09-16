import 'package:flutter/material.dart';
import 'package:frontend/components/dishes_app_bar.dart';
import 'package:frontend/components/dishes_drawer.dart';
import 'package:frontend/components/dishes_list.dart';

class LikedDishes extends StatelessWidget {
  const LikedDishes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 245, 228),
      appBar: DishesAppBar(title: 'Polubione potrawy', appBar: AppBar()),
      drawer: DishesDrawer(),
      body: DishesList(deleteOperation: true),
    );
  }
}
