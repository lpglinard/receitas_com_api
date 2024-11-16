import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receitas_com_api/providers/recipes_provider.dart';
import '../pages/recipe_detail_page.dart';

class ResultsList extends StatelessWidget {
  final TextEditingController searchController;

  ResultsList({required this.searchController});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);

    // Check if the search box is empty
    if (searchController.text.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Search a new recipe',
          style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
          textAlign: TextAlign.center,
        ),
      );
    }

    // Display "No recipes found" if the search returns no results
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

    // Display the list of recipes if available
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: recipeProvider.recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipeProvider.recipes[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: ListTile(
            title: Text(
              recipe.title,
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RecipeDetailPage(recipeId: recipe.id),
              ));
            },
          ),
        );
      },
    );
  }
}
