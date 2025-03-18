import 'package:flutter/material.dart';
import 'package:frontend/models/dish.dart';
import 'package:google_fonts/google_fonts.dart';
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

  //192.168.0.10 -Gli || 192.168.3.4 -Cis
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

  //TODO: depending on argument shows delete or subscribe and opens diffrent overlays
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dishesData.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => _dishDialog(context, index),
          child: Center(
            child: Container(
              margin: EdgeInsets.all(5),
              width: MediaQuery.sizeOf(context).width * 0.9,
              height: 230,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Color.fromARGB(255, 149, 35, 35),
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color.fromARGB(255, 149, 35, 35),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    height: 170,
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(dishesData[index].pictureUrl),
                        fit: BoxFit.fill,
                      ),
                      border: Border.all(
                        width: 3,
                        color: const Color.fromARGB(255, 255, 245, 228),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: const Color.fromARGB(255, 255, 245, 228),
                    ),
                  ),
                  Stack(
                    children: [
                      Center(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.sizeOf(context).width * 0.7,
                          ),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: const Color.fromARGB(255, 255, 245, 228),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: const Color.fromARGB(255, 255, 245, 228),
                          ),
                          child: Text(
                            dishesData[index].name,
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                color: Color.fromARGB(255, 149, 35, 35),
                              ),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.delete,
                          size: 35,
                          color: const Color.fromARGB(255, 255, 245, 228),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //TODO: add delete/sub button and design of dialog

  Future<void> _dishDialog(BuildContext context, int index) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(dishesData[index].name),
          children: <Widget>[
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 170,
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(dishesData[index].pictureUrl),
                      fit: BoxFit.fill,
                    ),
                    border: Border.all(
                      width: 3,
                      color: const Color.fromARGB(255, 255, 245, 228),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: const Color.fromARGB(255, 255, 245, 228),
                  ),
                ),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: <Widget>[
                    if (dishesData[index].porkTag)
                      Chip(label: Text('#wieprzowina')),
                    if (dishesData[index].beefTag)
                      Chip(label: Text('#wołowina')),
                    if (dishesData[index].chickenTag)
                      Chip(label: Text('#kurczak')),
                    if (dishesData[index].eggTag) Chip(label: Text('#jajka')),
                    if (dishesData[index].fishTag) Chip(label: Text('#ryba')),
                    if (dishesData[index].shellfishTag)
                      Chip(label: Text('#skorupiaki')),
                    if (dishesData[index].tofuTag) Chip(label: Text('#tofu')),
                    if (dishesData[index].pastaTag)
                      Chip(label: Text('#makaron')),
                    if (dishesData[index].riceTag) Chip(label: Text('#ryż')),
                    if (dishesData[index].groatsTag)
                      Chip(label: Text('#kasza')),
                    if (dishesData[index].soupTag) Chip(label: Text('#zupa')),
                    if (dishesData[index].saladTag)
                      Chip(label: Text('#sałatka')),
                    if (dishesData[index].vegetablesTag)
                      Chip(label: Text('#warzywa')),
                    if (dishesData[index].chesseTag) Chip(label: Text('#ser')),
                    if (dishesData[index].fruitTag) Chip(label: Text('#owoce')),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
