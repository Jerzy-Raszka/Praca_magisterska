const mongoose = require('mongoose');

const dishSuggestionSchema = new mongoose.Schema({
  name: String,
  celiacStatus: Boolean,
  dairyStatus: Boolean,
  halalStatus: Boolean,
  ketoStatus: Boolean,
  kosherStatus: Boolean,
  fodmapStatus: Boolean,
  paleoStatus: Boolean,
  pescetarianStatus: Boolean,
  veganStatus: Boolean,
  vegetarianStatus: Boolean,
  eggsAlergStatus: Boolean,
  milkAlergStatus: Boolean,
  mustardAlergStatus: Boolean,
  nutAlergStatus: Boolean,
  fishAlergStatus: Boolean,
  sesameAlergStatus: Boolean,
  soyAlergStatus: Boolean,
  wheatAlergStatus: Boolean,
  shellfishAlergStatus: Boolean,
  porkTag: Boolean,
  beefTag: Boolean,
  chickenTag: Boolean,
  eggTag: Boolean,
  fishTag: Boolean,
  shellfishTag: Boolean,
  tofuTag: Boolean,
  pastaTag: Boolean,
  riceTag: Boolean,
  groatsTag: Boolean,
  soupTag: Boolean,
  saladTag: Boolean,
  vegetablesTag: Boolean,
  chesseTag: Boolean,
  fruitTag: Boolean,
  pictureUrl: String,
});

const dishesItem = mongoose.model('dishesItem', dishSuggestionSchema);
module.exports = dishesItem;