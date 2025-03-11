import 'package:flutter/material.dart';
import 'package:frontend/models/dish.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DishesList extends StatefulWidget {
  const DishesList({super.key});

  @override
  State<DishesList> createState() => _DishesList();
}

class _DishesList extends State<DishesList> {
  List<Dish> dishesData = [];

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
      setState(() {
        dishesData =
            decodedJson.map<Dish>((item) => Dish.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  //TODO: widget factory that build widget for dishes
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dishesData.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(child: ListTile(title: Text(dishesData[index].name)));
      },
    );
  }
}
