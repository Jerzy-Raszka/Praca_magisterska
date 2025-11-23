import 'dart:convert';

import 'package:flutter/material.dart';
import 'dishes_tag.dart';
import '../models/dish.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DishesList extends StatefulWidget {
  final bool deleteOperation;
  // Optional: initial data for tests or preview (if provided, network fetch is skipped)
  final List<Dish>? initialData;
  // Optional http client to allow injecting a MockClient in tests
  final http.Client? httpClient;

  const DishesList({
    super.key,
    required this.deleteOperation,
    this.initialData,
    this.httpClient,
  });

  @override
  State<DishesList> createState() => _DishesList();
}

class _DishesList extends State<DishesList> {
  List<Dish> dishesData = [];
  Map<String, int> tagWeight = {
    "porkTag": 0,
    "beefTag": 0,
    "chickenTag": 0,
    "eggTag": 0,
    "fishTag": 0,
    "shellfishTag": 0,
    "tofuTag": 0,
    "pastaTag": 0,
    "riceTag": 0,
    "groatsTag": 0,
    "soupTag": 0,
    "saladTag": 0,
    "vegetablesTag": 0,
    "chesseTag": 0,
    "fruitTag": 0,
  };
  late Set<String> savedDishesID;

  @override
  void initState() {
    super.initState();
    // Ensure savedDishesID is initialized to a non-null set to avoid null checks in builds
    savedDishesID = <String>{};

    // If initialData is provided (tests / preview), use it and skip network fetch
    if (widget.initialData != null) {
      dishesData = widget.initialData!;
      _countTagsDishes();
      _countTotalTagWeight();
      _sortDishes();
    } else {
      _fetchPreferences();
    }
  }

  void _fetchPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final diet = prefs.getString('diet') ?? '';
    final keys = prefs.getKeys();
    List<String> allergens = [];

    for (String key in keys) {
      if (key.endsWith('AlergStatus') && prefs.getBool(key) == true) {
        allergens.add(key);
      }
    }

    _fetchData(diet, allergens);
  }

  //188.245.110.118 -VPS || 192.168.3.4:3000 -Cis
  bool _isLoading = false;
  String? _errorMessage;

  void _fetchData(diet, allergens) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final prefs = await SharedPreferences.getInstance();
    final uri = Uri.http('188.245.110.118', '/dishes', {
      'diets': diet,
      'allergens': allergens.join(','),
    });

    int retryCount = 0;
    const int maxRetries = 3;
    const Duration retryDelay = Duration(seconds: 1);

    while (retryCount < maxRetries) {
      try {
        final client = widget.httpClient ?? http.Client();
        final response = await client.get(uri).timeout(Duration(seconds: 2));
        savedDishesID = prefs.getKeys();
        if (response.statusCode == 200) {
          final decodedJson = jsonDecode(response.body);
          setState(() {
            dishesData =
                decodedJson.map<Dish>((item) => Dish.fromJson(item)).toList();

            if (widget.deleteOperation) {
              dishesData =
                  dishesData
                      .where((dish) => savedDishesID.contains(dish.id))
                      .toList();
            }

            _countTagsDishes();
            _countTotalTagWeight();
            _sortDishes();
            _isLoading = false;
            _errorMessage = null;
          });
          return;
        } else {
          retryCount++;
          if (retryCount >= maxRetries) {
            setState(() {
              _isLoading = false;
              _errorMessage =
                  'Failed to fetch data (status ${response.statusCode})';
            });
          } else {
            await Future.delayed(retryDelay);
          }
        }
      } catch (e) {
        retryCount++;
        if (retryCount >= maxRetries) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Failed to connect to server.';
          });
        } else {
          await Future.delayed(retryDelay);
        }
      }
    }
  }

  void _countTagsDishes() {
    for (var dish in dishesData) {
      if (savedDishesID.contains(dish.id)) {
        if (dish.porkTag) {
          tagWeight["porkTag"] = tagWeight["porkTag"]! + 1;
        }
        if (dish.beefTag) {
          tagWeight["beefTag"] = tagWeight["beefTag"]! + 1;
        }
        if (dish.chickenTag) {
          tagWeight["chickenTag"] = tagWeight["chickenTag"]! + 1;
        }
        if (dish.eggTag) {
          tagWeight["eggTag"] = tagWeight["eggTag"]! + 1;
        }
        if (dish.fishTag) {
          tagWeight["fishTag"] = tagWeight["fishTag"]! + 1;
        }
        if (dish.shellfishTag) {
          tagWeight["shellfishTag"] = tagWeight["shellfishTag"]! + 1;
        }
        if (dish.tofuTag) {
          tagWeight["tofuTag"] = tagWeight["tofuTag"]! + 1;
        }
        if (dish.pastaTag) {
          tagWeight["pastaTag"] = tagWeight["pastaTag"]! + 1;
        }
        if (dish.riceTag) {
          tagWeight["riceTag"] = tagWeight["riceTag"]! + 1;
        }
        if (dish.groatsTag) {
          tagWeight["groatsTag"] = tagWeight["groatsTag"]! + 1;
        }
        if (dish.soupTag) {
          tagWeight["soupTag"] = tagWeight["soupTag"]! + 1;
        }
        if (dish.saladTag) {
          tagWeight["saladTag"] = tagWeight["saladTag"]! + 1;
        }
        if (dish.vegetablesTag) {
          tagWeight["vegetablesTag"] = tagWeight["vegetablesTag"]! + 1;
        }
        if (dish.chesseTag) {
          tagWeight["chesseTag"] = tagWeight["chesseTag"]! + 1;
        }
        if (dish.fruitTag) {
          tagWeight["fruitTag"] = tagWeight["fruitTag"]! + 1;
        }
      }
    }
  }

  void _countTotalTagWeight() {
    for (var dish in dishesData) {
      int weight = 0;
      if (dish.porkTag) weight += tagWeight["porkTag"]!;
      if (dish.beefTag) weight += tagWeight["beefTag"]!;
      if (dish.chickenTag) weight += tagWeight["chickenTag"]!;
      if (dish.eggTag) weight += tagWeight["eggTag"]!;
      if (dish.fishTag) weight += tagWeight["fishTag"]!;
      if (dish.shellfishTag) weight += tagWeight["shellfishTag"]!;
      if (dish.tofuTag) weight += tagWeight["tofuTag"]!;
      if (dish.pastaTag) weight += tagWeight["pastaTag"]!;
      if (dish.riceTag) weight += tagWeight["riceTag"]!;
      if (dish.groatsTag) weight += tagWeight["groatsTag"]!;
      if (dish.soupTag) weight += tagWeight["soupTag"]!;
      if (dish.saladTag) weight += tagWeight["saladTag"]!;
      if (dish.vegetablesTag) weight += tagWeight["vegetablesTag"]!;
      if (dish.chesseTag) weight += tagWeight["chesseTag"]!;
      if (dish.fruitTag) weight += tagWeight["fruitTag"]!;
      dish.totalTagWeight = weight;
    }
  }

  void _sortDishes() {
    dishesData.sort((a, b) => b.totalTagWeight.compareTo(a.totalTagWeight));
  }

  Future<void> _saveDish(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString(dishesData[index].id, dishesData[index].id);
      savedDishesID.add(dishesData[index].id);
      Navigator.pop(context);
    });
  }

  Future<void> _deleteDish(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove(dishesData[index].id);
      dishesData.removeWhere((dish) => dish.id == dishesData[index].id);
      Navigator.pop(context);
    });
  }

  bool _isLiked(int index) {
    return savedDishesID.contains(dishesData[index].id) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator(color: Colors.red));
    }
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _errorMessage!,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(color: Color.fromARGB(255, 149, 35, 35)),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: _fetchPreferences,
              style: ButtonStyle(
                padding: WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 42, vertical: 16),
                ),
                backgroundColor: WidgetStatePropertyAll<Color>(
                  const Color.fromARGB(77, 149, 35, 35),
                ),
              ),
              child: Text(
                'Ponów próbę',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(color: Color.fromARGB(255, 149, 35, 35)),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }
    return PopScope(
      canPop: false,
      child: ListView.builder(
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
                        image:
                            dishesData[index].pictureUrl.isNotEmpty
                                ? DecorationImage(
                                  image: NetworkImage(
                                    dishesData[index].pictureUrl,
                                  ),
                                  fit: BoxFit.fill,
                                )
                                : null,
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
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
                        if (!_isLiked(index) || widget.deleteOperation)
                          Container(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              widget.deleteOperation
                                  ? Icons.delete
                                  : Icons.favorite,
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
      ),
    );
  }

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
                        image:
                            dishesData[index].pictureUrl.isNotEmpty
                                ? DecorationImage(
                                  image: NetworkImage(
                                    dishesData[index].pictureUrl,
                                  ),
                                  fit: BoxFit.fill,
                                )
                                : null,
                        border: Border.all(
                          width: 3,
                          color: const Color.fromARGB(255, 149, 35, 35),
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
                    if (!_isLiked(index) || widget.deleteOperation)
                      GestureDetector(
                        onTap: () {
                          widget.deleteOperation
                              ? _deleteDish(index)
                              : _saveDish(index);
                        },
                        child: Container(
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
                              widget.deleteOperation
                                  ? "Usuń z ulubiobych"
                                  : "Dodaj do ulubionych",
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
