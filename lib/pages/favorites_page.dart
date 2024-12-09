import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/recipe_detail_page.dart';
import '../providers/recipes_provider.dart';

class FavoritesPage extends StatelessWidget {
  static final routeName = "/favorites";

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final favorites = recipeProvider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Recipes"),
      ),
      body: favorites.isEmpty
          ? Center(
        child: Text(
          "No favorites yet.",
          style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
        ),
      )
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final recipe = favorites[index];
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
                  builder: (context) =>
                      RecipeDetailPage(recipeId: recipe.id),
                ));
              },
            ),
          );
        },
      ),
    );
  }
}
