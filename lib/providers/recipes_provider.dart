import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import '../model/recipe.dart';

class RecipeProvider with ChangeNotifier {
  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  List<Recipe> _favorites = [];
  List<Recipe> get favorites => _favorites;

  Future<void> searchRecipes(String query) async {
    final apiKey = dotenv.env['API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API key is missing in the .env file');
    }

    final url = Uri.parse(
        'https://api.spoonacular.com/recipes/complexSearch?query=$query&apiKey=$apiKey');
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
    final apiKey = dotenv.env['API_KEY']; // Fetch the API key from the .env file
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API key is missing in the .env file');
    }

    final url = Uri.parse(
        'https://api.spoonacular.com/recipes/$recipeId/information?apiKey=$apiKey');
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
