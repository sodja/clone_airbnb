
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration customDecoration () {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        offset: Offset(0,2),
        color: Colors.grey,
        blurRadius: 5,
      )],
  );
}

Container continueWith(String image) {
  return Container(
    padding: const EdgeInsets.all(15),
    height: 50,
    decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: Offset(0,3),
              color: Colors.grey,
              blurRadius: 5
          )
        ]

    ),
    child: Image.asset(image,),
  );
}

Padding buildScrollActivities(String text,String imgUri){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      children: <Widget>[
        Container(
            color: Colors.white,
            height: 250,
            width: 350,
            child: Image.asset(imgUri,fit: BoxFit.fill,)
        ),
        Container(
            width: double.infinity,
            color: Colors.black,
            child: Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
      ],
    ),
  );
}