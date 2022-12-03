//import 'package
const express=require('express');
const mongoose =require("mongoose");
//import other file;
const authRouter=require('./routes/auth');

//init
const PORT =3000;
const app=express();
const DB="mongodb+srv://dreanit:Sahil3005@cluster0.6be2l2u.mongodb.net/?retryWrites=true&w=majority";
//middleware
//CLIENT -> SERVER-> CLIENT
app.use(express.json());
app.use(authRouter);

//connections
mongoose.connect(DB).then(()=>{
    console.log("connection successful");
}).catch((e)=>{console.log(e);});

app.listen(PORT,"0.0.0.0",()=>{
console.log(`connected at port ${PORT}`);});