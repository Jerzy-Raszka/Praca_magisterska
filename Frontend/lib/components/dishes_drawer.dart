import 'package:flutter/material.dart';
import 'package:frontend/components/dishes_preferences.dart';
import 'package:frontend/components/recommended_dishes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'liked_dishes.dart';

class DishesDrawer extends StatefulWidget {
  const DishesDrawer({super.key});

  @override
  State<DishesDrawer> createState() => _DishesDrawerState();
}

class _DishesDrawerState extends State<DishesDrawer> {
  //TODO: change clearing data button to be more visible and on the bottom of drawer
  //TODO: _removeData() navigate to preferences after "yes"

  void _clearPref() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> _removeData() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 255, 245, 228),
          title: Text(
            'Czy napewno chcesz usunąc wszystkie dane?',
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: const Color.fromARGB(255, 149, 35, 35),
              ),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(height: 50),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                      color: const Color.fromARGB(255, 149, 35, 35),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: const Color.fromARGB(255, 149, 35, 35),
                  ),
                  child: TextButton(
                    onPressed: () {
                      _clearPref();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RecommendedDishes(),
                        ),
                      );
                    },
                    child: Text(
                      "Tak",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: const Color.fromARGB(255, 255, 245, 228),
                        ),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                      color: const Color.fromARGB(255, 149, 35, 35),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: const Color.fromARGB(255, 149, 35, 35),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Nie",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: const Color.fromARGB(255, 255, 245, 228),
                        ),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 255, 245, 228),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 116.3,
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
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LikedDishes()),
                );
              },
              child: Padding(
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
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DishesPreferences(),
                  ),
                );
              },
              child: Padding(
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
            ),
            GestureDetector(
              onTap: () {
                _removeData();
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 80, 12, 80),
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
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecommendedDishes(),
                  ),
                );
              },
              child: Padding(
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
            ),
          ],
        ),
      ),
    );
  }
}
