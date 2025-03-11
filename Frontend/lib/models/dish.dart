class Dish {
  final String name;
  final bool porkTag;
  final bool beefTag;
  final bool chickenTag;
  final bool eggTag;
  final bool fishTag;
  final bool shellfishTag;
  final bool tofuTag;
  final bool pastaTag;
  final bool riceTag;
  final bool groatsTag;
  final bool soupTag;
  final bool saladTag;
  final bool vegetablesTag;
  final bool chesseTag;
  final bool fruitTag;
  final String pictureUrl;

  const Dish({
    required this.name,
    required this.porkTag,
    required this.beefTag,
    required this.chickenTag,
    required this.eggTag,
    required this.fishTag,
    required this.shellfishTag,
    required this.tofuTag,
    required this.pastaTag,
    required this.riceTag,
    required this.groatsTag,
    required this.soupTag,
    required this.saladTag,
    required this.vegetablesTag,
    required this.chesseTag,
    required this.fruitTag,
    required this.pictureUrl,
  });

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
    name: json["name"],
    porkTag: json["porkTag"],
    beefTag: json["beefTag"],
    chickenTag: json["chickenTag"],
    eggTag: json["eggTag"],
    fishTag: json["fishTag"],
    shellfishTag: json["shellfishTag"],
    tofuTag: json["tofuTag"],
    pastaTag: json["pastaTag"],
    riceTag: json["riceTag"],
    groatsTag: json["groatsTag"],
    soupTag: json["soupTag"],
    saladTag: json["saladTag"],
    vegetablesTag: json["vegetablesTag"],
    chesseTag: json["chesseTag"],
    fruitTag: json["fruitTag"],
    pictureUrl: json["pictureUrl"],
  );
}
