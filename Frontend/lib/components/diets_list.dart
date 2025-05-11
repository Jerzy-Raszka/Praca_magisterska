import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DietsList extends StatefulWidget {
  const DietsList({super.key});

  @override
  State<DietsList> createState() => _DietsList();
}

class _DietsList extends State<DietsList> {
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

  //TODO: Style diet dropdown menu
  //TODO: Checkboxes with allergens
  //TODO: Saved chosen diet and alergens to shared preference with syntax to find by key

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton(
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
    );
  }
}
