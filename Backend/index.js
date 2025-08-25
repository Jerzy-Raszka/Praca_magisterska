const express = require('express')
const app = express()
const port = 3000
const mongoose = require('mongoose');
const dishesItem = require('./schemas');

app.use(express.json())

app.use(function (req, res, next) {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
    res.setHeader(
        'Access-Control-Allow-Headers', 'X-Requested-With,content-type');
    next();
})

mongoose.connect(
    'mongodb+srv://Jirru:eQNToZhbNvEtI1cB@cluster0.hibixil.mongodb.net/Dishes?retryWrites=true&w=majority&appName=Cluster0')

app.get('/dishes', async (req, res) => {
    const diet = req.query.diets || '';
    const allergenFilters = req.query.allergens?.split(',') || [];

    const query = {
        $and: [
            ...(diet
                ? [{[diet]: true}]
                : []),
            ...allergenFilters.map(key => ({[key]: {$ne: true}}))
        ]
    };

    const dishes = await dishesItem.find(query);
    res.send(dishes);
});


app.post('/dishes', async (req, res) => {
    const newDishesItem = await dishesItem.create(req.body);
    res.send(newDishesItem)
});

app.put('/dishes', async (req, res) => {
    console.log(req.body)
    await dishesItem.findByIdAndUpdate(
        {_id: req.body._id}, req.body)
    res.send(await dishesItem.find({}))
})

app.delete('/dishes', async (req, res) => {
    await dishesItem.findByIdAndDelete({_id: req.body._id})
    res.send(await dishesItem.find({}))
})

app.listen(
    port, '0.0.0.0', () => {
        console.log(`Listening on port http://localhost:${port}`)
    })