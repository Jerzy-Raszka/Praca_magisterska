import 'package:flutter/material.dart';
import 'package:frontend/components/dishes_tag.dart';
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

  //TODO: button del/sub and calling diffrent functions

  Future<void> _dishDialog(BuildContext context, int index) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: const Color.fromARGB(255, 255, 245, 228),
          title: Text(
            dishesData[index].name,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: const Color.fromARGB(255, 149, 35, 35),
              ),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.6,
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      height: 170,
                      width: MediaQuery.sizeOf(context).width * 0.7,
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
                          DishesTag(tag: "Wieprzowina"),
                        if (dishesData[index].beefTag)
                          DishesTag(tag: "Wołowina"),
                        if (dishesData[index].chickenTag)
                          DishesTag(tag: "Kurczak"),
                        if (dishesData[index].eggTag) DishesTag(tag: "Jajka"),
                        if (dishesData[index].fishTag) DishesTag(tag: "Ryba"),
                        if (dishesData[index].shellfishTag)
                          DishesTag(tag: "Skorupiaki"),
                        if (dishesData[index].tofuTag) DishesTag(tag: "Tofu"),
                        if (dishesData[index].pastaTag)
                          DishesTag(tag: "Makaron"),
                        if (dishesData[index].riceTag) DishesTag(tag: "Ryż"),
                        if (dishesData[index].groatsTag)
                          DishesTag(tag: "Kasza"),
                        if (dishesData[index].soupTag) DishesTag(tag: "Zupa"),
                        if (dishesData[index].saladTag)
                          DishesTag(tag: "Sałatka"),
                        if (dishesData[index].vegetablesTag)
                          DishesTag(tag: "Warzywa"),
                        if (dishesData[index].chesseTag) DishesTag(tag: "Ser"),
                        if (dishesData[index].fruitTag) DishesTag(tag: "Owoce"),
                      ],
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.all(5),
                      height: 50,
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: const Color.fromARGB(255, 149, 35, 35),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: const Color.fromARGB(255, 149, 35, 35),
                      ),
                      child: Center(
                        child: Text(
                          'Dodaj lub usuń',
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
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
