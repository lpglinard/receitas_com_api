import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receitas_com_api/providers/recipes_provider.dart';
import '../pages/recipe_detail_page.dart';

class ResultsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, recipeProvider, child) {
        if (recipeProvider.recipes.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'No recipes found.',
              style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
              textAlign: TextAlign.center,
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: recipeProvider.recipes.length,
          itemBuilder: (context, index) {
            final recipe = recipeProvider.recipes[index];
            return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RecipeDetailPage(recipeId: recipe.id),
                ));
              },
              title: Text(
                recipe.title,
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              trailing: IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  // Add favorite functionality here
                },
              ),
            );
          },
        );
      },
    );
  }
}
