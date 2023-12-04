import 'package:flutter/material.dart';

Widget searchContainer() {
  return Container(
    height: 40,
    width: double.infinity,
    decoration: BoxDecoration(
      color:  const Color.fromRGBO(225, 225, 226, 0.6),
      borderRadius: BorderRadius.circular(10)
    ),
    child: const TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Search",
        prefixIcon: Icon(Icons.search,color: Colors.black26,),
        hintStyle: TextStyle(
          color: Colors.black26
        ),
        suffixIcon: Icon(Icons.tune,color: Colors.black26,)

      ),

      
    
    ),
  );
}
