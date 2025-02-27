import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DishesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;

  const DishesAppBar({super.key, required this.title, required this.appBar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
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

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
