import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DishesAlergen extends StatefulWidget {
  final bool allergen;
  final String allergenName;
  final ValueChanged<bool> onChanged;

  const DishesAlergen({
    super.key,
    required this.allergen,
    required this.allergenName,
    required this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _DishesAlergenState();
}

class _DishesAlergenState extends State<DishesAlergen> {
  late bool isChecked = widget.allergen;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      backgroundColor: const Color.fromARGB(77, 149, 35, 35),
      avatar: Icon(
        widget.allergen ? Icons.check_box : Icons.check_box_outline_blank,
        color: const Color.fromARGB(255, 149, 35, 35),
        size: 24,
      ),
      label: Text(
        widget.allergenName,
        style: GoogleFonts.roboto(
          textStyle: TextStyle(color: const Color.fromARGB(255, 149, 35, 35)),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        setState(() {
          isChecked = !isChecked;
        });
        widget.onChanged(isChecked);
      },
    );
  }
}
