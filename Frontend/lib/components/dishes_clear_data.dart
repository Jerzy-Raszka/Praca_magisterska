import 'package:flutter/material.dart';
import 'package:frontend/components/recommended_dishes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DishesClearData extends StatefulWidget {
  const DishesClearData({super.key});

  @override
  State<DishesClearData> createState() => _DishesClearDataState();
}

class _DishesClearDataState extends State<DishesClearData> {
  @override
  void initState() {
    super.initState();
  }

  void _clearPref() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  //TODO: style the dialog and navigate and navigate to preferences
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Czy napewno chcesz usunąć wszystkie dane"),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: () {
            _clearPref();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RecommendedDishes(),
              ),
            );
          },
          child: const Text("tak"),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RecommendedDishes(),
              ),
            );
          },
          child: const Text("nie"),
        ),
      ],
    );
  }
}
