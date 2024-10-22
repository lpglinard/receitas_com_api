import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receitas_com_api/pages/home_page.dart';
import 'package:receitas_com_api/pages/about_us.dart';
import 'package:receitas_com_api/providers/recipes_provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RecipeProvider>(create: (_) => RecipeProvider() )
      ],
      child: MaterialApp(
        title: 'RecipeIt',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.orange,
        ),
        home: HomePage(),
        routes:
        {AboutUs.routeName: (context) => AboutUs()}

      ),
    );
  }
}
