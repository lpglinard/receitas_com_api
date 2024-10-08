import 'package:flutter/material.dart';
import 'package:receitas_com_api/pages/home_page.dart';
import 'package:receitas_com_api/pages/recipe.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeIt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.orange,
      ),
      home: HomePage(),
      routes: {
        '/': (context) => AboutUs(),
      }
    );
  }
}
