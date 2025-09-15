import 'package:flutter/material.dart';
import 'package:frontend/components/dishes_allergen.dart';
import 'package:frontend/models/alergen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/components/recommended_dishes.dart';

class DietsList extends StatefulWidget {
  const DietsList({super.key});

  @override
  State<DietsList> createState() => _DietsList();
}

class _DietsList extends State<DietsList> {
  List<Alergen> allergenList = [
    Alergen(name: "milkAlergStatus", shownName: "Mleko krowie", status: false),
    Alergen(name: "fishAlergStatus", shownName: "Ryby", status: false),
    Alergen(name: "sesameAlergStatus", shownName: "Sezam", status: false),
    Alergen(name: "mustardAlergStatus", shownName: "Gorczyca", status: false),
    Alergen(name: "wheatAlergStatus", shownName: "Pszczenica", status: false),
    Alergen(name: "soyAlergStatus", shownName: "Soja", status: false),
    Alergen(name: "nutAlergStatus", shownName: "Orzechy", status: false),
    Alergen(
      name: "shellfishAlergStatus",
      shownName: "Skorupiaki",
      status: false,
    ),
    Alergen(name: "eggsAlergStatus", shownName: "Jajka", status: false),
  ];

  static const Map<String, String> dietList = {
    "Brak diety": "",
    "Dieta bezglutenowa": "celiacStatus",
    "Dieta bezlaktozowa": "dairyStatus",
    "Dieta halal": "halalStatus",
    "Dieta keto": "ketoStatus",
    "Dieta koszerna": "kosherStatus",
    "Dieta FODMAP": "fodmapStatus",
    "Dieta paleo": "paleoStatus",
    "Dieta peskatariańska": "pescetarianStatus",
    "Dieta wegańska": "veganStatus",
    "Dieta wegetariańska": "vegetarianStatus",
  };
  String dropdownValue = dietList.keys.first;
  String? diet;

  @override
  void initState() {
    super.initState();
    _getAlergens();
  }

  void _getAlergens() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var allergen in allergenList) {
        final value = prefs.getBool(allergen.name);
        allergen.status = value ?? false;
      }
      diet = prefs.getString('diet');
      dropdownValue =
          dietList.entries
              .firstWhere(
                (entry) => entry.value == diet,
                orElse: () => const MapEntry("Brak diety", "Brak diety"),
              )
              .key;
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    for (var allergen in allergenList) {
      await prefs.setBool(allergen.name, allergen.status);
    }
    await prefs.setString('diet', dietList[dropdownValue] ?? '');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RecommendedDishes()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            "Wybrana dieta:",
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: const Color.fromARGB(255, 149, 35, 35),
              ),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.9,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 5,
                  color: const Color.fromARGB(255, 149, 35, 35),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton(
                dropdownColor: const Color.fromARGB(255, 255, 245, 228),
                isExpanded: true,
                value: dropdownValue,
                elevation: 16,
                items:
                    dietList.keys.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              color: Color.fromARGB(255, 149, 35, 35),
                            ),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
              ),
            ),
          ),
        ),
        Container(height: 200),
        Text(
          "Lista alergenów:",
          style: GoogleFonts.roboto(
            textStyle: TextStyle(color: const Color.fromARGB(255, 149, 35, 35)),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(22, 30, 22, 130),
          child: Wrap(
            spacing: 5,
            runSpacing: 3,
            children: [
              ...allergenList.map(
                (allergen) => DishesAlergen(
                  allergen: allergen.status,
                  allergenName: allergen.shownName,
                  onChanged: (newValue) {
                    setState(() {
                      allergen.status = newValue;
                    });
                  },
                ),
              ),
            ],
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
            onPressed: () => _savePreferences(),
            child: Text(
              "Zapisz",
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
    );
  }
}
