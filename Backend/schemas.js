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
  pictureUrl: String,
});


module.exports = {dishSuggestionSchema}