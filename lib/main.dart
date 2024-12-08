import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receitas_com_api/pages/home_page.dart';
import 'package:receitas_com_api/pages/favorites_page.dart';
import 'package:receitas_com_api/providers/recipes_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: "lib/assets/.env");
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RecipeProvider>(create: (_) => RecipeProvider())
      ],
      child: MaterialApp(
        title: 'RecipeIt',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: Color(0xFFFFF3E0),
          appBarTheme: AppBarTheme(
            color: Color(0xFFFFA736),
            titleTextStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,

            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
        ),
        home: HomePage(),
        routes: {
          FavoritesPage.routeName: (context) => FavoritesPage(),
        },
      ),
    );
  }
}
