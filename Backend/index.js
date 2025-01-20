const express = require('express')
const app = express()
const port = 3000
const mongoose = require('mongoose');
const {dishSuggestionSchema} = require("./schemas");

// TODO: Put schema into separate file export it

app.use(express.json())

app.use(function(req, res, next) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
  res.setHeader(
      'Access-Control-Allow-Headers', 'X-Requested-With,content-type');
  next();
})

const dishesItem = mongoose.model('dishesItem', dishSuggestionSchema);

mongoose.connect(
    'mongodb+srv://Jirru:eQNToZhbNvEtI1cB@cluster0.hibixil.mongodb.net/Dishes?retryWrites=true&w=majority&appName=Cluster0')

app.get('/dishes', async (req, res) => {res.send(await dishesItem.find({}))});

app.post('/dishes', async (req, res) => {
  const newDishesItem = await dishesItem.create(req.body.name);
  res.send(newDishesItem)
});

// TODO: fix POST body

// app.put('/dishes', async (req, res) => {
//   console.log(req.body);
//   await dishesItem.findByIdAndUpdate(
//       {_id: req.body._id}, {name: req.body.name, status: req.body.status})
//   res.send(await dishesItem.find({}))
// })

// app.delete('/dishes', async (req, res) => {
//     await dishesItem.findByIdAndDelete({_id: req.body._id})
//     res.send(await dishesItem.find({}))
// })

app.listen(
    port, () => {console.log(`Listening on port http://localhost:${port}`)})