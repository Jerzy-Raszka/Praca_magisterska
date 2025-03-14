import 'package:flutter/material.dart';
import 'package:frontend/components/dish_dialog.dart';
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

  void _fetchData() async {
    final response = await http.get(
      Uri.parse('http://192.168.3.4:3000/dishes'), //192.168.0.10
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
          onTap: () {
            DishDialog();
          },
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
}
