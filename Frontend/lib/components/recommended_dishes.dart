import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendedDishes extends StatelessWidget {
  const RecommendedDishes({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 245, 228),
      drawer: Drawer(), //TODO: universal drawer widget
      appBar: appBar(),
      body: Text('kappa'), //TODO: body: widget builder
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        'Polecane przepisy',
        style: GoogleFonts.roboto(
          textStyle: TextStyle(color: Color.fromARGB(255, 255, 245, 228)),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Color.fromARGB(255, 149, 35, 35),
      elevation: 0.0,
      centerTitle: true,
    );
  }
}
