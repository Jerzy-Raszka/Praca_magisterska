import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DishesList extends StatefulWidget {
  const DishesList({super.key});

  @override
  State<DishesList> createState() => _DishesList();
}

class _DishesList extends State<DishesList> {
  List<String> dishesName = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    final response = await http.get(
      Uri.parse('http://192.168.0.10:3000/dishes'),
    );
    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      //TODO: put json into list for future use in widgets
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  //TODO: widget factory that build depending on fetched data
  @override
  Widget build(BuildContext context) {
    return Text(
      'name',
      style: GoogleFonts.roboto(
        textStyle: TextStyle(color: Color.fromARGB(255, 255, 245, 228)),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
