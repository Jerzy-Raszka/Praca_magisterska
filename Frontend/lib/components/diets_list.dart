import 'package:flutter/material.dart';
import 'package:frontend/components/dishes_allergen.dart';
import 'package:google_fonts/google_fonts.dart';

class DietsList extends StatefulWidget {
  const DietsList({super.key});

  @override
  State<DietsList> createState() => _DietsList();
}

class _DietsList extends State<DietsList> {
  static const List<String> allergenList = <String>[
    "Mleko krowie",
    "Ryby",
    "Sezam",
    "Gorczyca",
    "Pszczenica",
    "Soja",
    "Orzechy",
    "Skorupiaki",
    "Jajka",
  ];

  static const List<String> dietList = <String>[
    "Brak diety",
    "Dieta bezglutenowa",
    "Dieta bezlaktozowa",
    "Dieta halal",
    "Dieta keto",
    "Dieta koszerna",
    "Dieta FODMAP",
    "Dieta paleo",
    "Dieta peskatariańska",
    "Dieta wegańska",
    "Dieta wegetariańska",
  ];
  String dropdownValue = dietList.first;

  @override
  void initState() {
    super.initState();
  }

  //TODO: Allergen object that have name and value true/false
  //TODO: Save to SharedPreferences all allergens with name as key and value true/false
  //TODO: Save to SharedPreferences chosen diet with key diet

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
                    dietList.map<DropdownMenuItem<String>>((String value) {
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
        Spacer(),
        Text(
          "Lista alergenów:",
          style: GoogleFonts.roboto(
            textStyle: TextStyle(color: const Color.fromARGB(255, 149, 35, 35)),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(22, 30, 22, 200),
          child: Wrap(
            spacing: 5,
            runSpacing: 3,
            children: [
              ...allergenList.map(
                (allergen) =>
                    DishesAlergen(allergen: false, allergenName: allergen),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
