import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DishesDrawer extends StatelessWidget {
  const DishesDrawer({super.key});
  //TODO: change to statefull and navigation on tap
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 255, 245, 228),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 89,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 149, 35, 35),
                ),
                child: Text(
                  'Menu',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 255, 245, 228),
                    ),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 50, 12, 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(
                    maxWidth: 300,
                    maxHeight: 80,
                  ),
                  color: Color.fromARGB(255, 149, 35, 35),
                  child: Center(
                    child: Text(
                      'Zapisane przepisy',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 255, 245, 228),
                        ),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(
                    maxWidth: 300,
                    maxHeight: 80,
                  ),
                  color: Color.fromARGB(255, 149, 35, 35),
                  child: Center(
                    child: Text(
                      'Zmień preferencje',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 255, 245, 228),
                        ),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 160, 12, 160),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(
                    maxWidth: 300,
                    maxHeight: 80,
                  ),
                  color: Color.fromARGB(255, 149, 35, 35),
                  child: Center(
                    child: Text(
                      'Usuń zapisane dane',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 255, 245, 228),
                        ),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(
                    maxWidth: 300,
                    maxHeight: 80,
                  ),
                  color: Color.fromARGB(255, 149, 35, 35),
                  child: Center(
                    child: Text(
                      'Polecane przepisy',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 255, 245, 228),
                        ),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
