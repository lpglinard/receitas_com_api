import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipes_provider.dart';
import '../pages/recipe_detail_page.dart';

class ResultsList extends StatelessWidget {
  final TextEditingController searchController;

  ResultsList({required this.searchController});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);

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
        final isFavorite = recipeProvider.favorites.contains(recipe);

        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    recipe.title,
                    style: TextStyle(fontFamily: 'Poppins'),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    recipeProvider.toggleFavorite(recipe);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isFavorite
                              ? 'Removed from favorites'
                              : 'Added to favorites',
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],
            ),
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
