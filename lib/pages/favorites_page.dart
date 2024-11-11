import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recipes_provider.dart';

class FavoritesPage extends StatelessWidget {
  static final routeName = "/favorites";

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<RecipeProvider>(context).favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Recipes"),
      ),
      body: favorites.isEmpty
          ? Center(
        child: Text(
          "No favorites yet.",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final recipe = favorites[index];
          return ListTile(
            title: Text(recipe.title),
          );
        },
      ),
    );
  }
}
