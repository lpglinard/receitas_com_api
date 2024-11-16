import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/recipe.dart';
import 'package:receitas_com_api/pages/favorites_page.dart';

class RecipeProvider with ChangeNotifier {
  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  List<Recipe> _favorites = [];
  List<Recipe> get favorites => _favorites;

  Future<void> searchRecipes(String query) async {
    final url = Uri.parse('https://api.spoonacular.com/recipes/complexSearch?query=$query&apiKey=3e49dfd66f1e461b8cf36db9e703693d');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _recipes = (data['results'] as List)
          .map<Recipe>((json) => Recipe.fromJson(json))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load recipes');
    }
  }
  Future<Recipe> fetchRecipeDetails(int recipeId) async {
    final url = Uri.parse(
        'https://api.spoonacular.com/recipes/$recipeId/information?apiKey=3e49dfd66f1e461b8cf36db9e703693d');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Recipe.fromJson(data);
    } else {
      throw Exception('Failed to load recipe details');
    }
  }

  void toggleFavorite(Recipe recipe) {
    if (_favorites.contains(recipe)) {
      _favorites.remove(recipe);
    } else {
      _favorites.add(recipe);
    }
    notifyListeners();
  }
}
