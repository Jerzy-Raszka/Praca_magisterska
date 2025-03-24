import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DishesTag extends StatelessWidget {
  final String tag;

  const DishesTag({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: const Color.fromARGB(77, 149, 35, 35),
      label: Text(
        tag,
        style: GoogleFonts.roboto(
          textStyle: TextStyle(color: const Color.fromARGB(255, 149, 35, 35)),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
