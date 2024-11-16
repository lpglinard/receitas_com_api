import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receitas_com_api/providers/recipes_provider.dart';
import '../model/recipe.dart';

class RecipeDetailPage extends StatefulWidget {
  final int recipeId;

  RecipeDetailPage({required this.recipeId});

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late Future<Recipe> _recipe;

  @override
  void initState() {
    super.initState();
    _recipe = Provider.of<RecipeProvider>(context, listen: false)
        .fetchRecipeDetails(widget.recipeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe Details"),
      ),
      body: FutureBuilder<Recipe>(
        future: _recipe,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error loading recipe details",
                style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
              ),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text(
                "No recipe found",
                style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
              ),
            );
          }

          final recipe = snapshot.data!;
          return Consumer<RecipeProvider>(
            builder: (context, recipeProvider, child) {
              final isFavorite = recipeProvider.favorites.contains(recipe);

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Recipe Title Row with Favorite Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              recipe.title,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              recipeProvider.toggleFavorite(recipe);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(isFavorite
                                    ? 'Removed from favorites'
                                    : 'Added to favorites'),
                                duration: Duration(seconds: 2),
                              ));
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Servings and Time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (recipe.servings != null)
                            Text(
                              "Servings: ${recipe.servings}",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          if (recipe.readyInMinutes != null)
                            Text(
                              "Ready in: ${recipe.readyInMinutes} mins",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Ingredients Section
                      Text(
                        "Ingredients",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 8),
                      if (recipe.ingredients.isNotEmpty)
                        ...recipe.ingredients.map((ingredient) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text("- $ingredient"),
                        )),
                      if (recipe.ingredients.isEmpty)
                        Text("No ingredients available"),
                      SizedBox(height: 16),

                      // Instructions Section
                      Text(
                        "Instructions",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 8),
                      if (recipe.instructions != null &&
                          recipe.instructions!.isNotEmpty)
                        Text(recipe.instructions!)
                      else
                        Text("No instructions available"),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
