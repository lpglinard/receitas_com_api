import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receitas_com_api/providers/recipes_provider.dart';

class ResultsList extends StatelessWidget {

  ResultsList();

  @override
  Widget build(BuildContext context) {
    if (recipes.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'No recipes found.',
          style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
          textAlign: TextAlign.center,
        ),
      );
    }
    return Consumer<RecipeProvider>(
      builder: (BuildContext context, RecipeProvider value, Widget? child) {
        return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: value.recipes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              value.recipes.elementAt(index).title,
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            leading: Icon(Icons.food_bank),
          );
        },
      );
      }
    );
  }
}
