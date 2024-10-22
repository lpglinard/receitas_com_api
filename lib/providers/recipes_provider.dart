import 'package:flutter/material.dart';
import 'package:receitas_com_api/model/recipe.dart';

class RecipeProvider with ChangeNotifier{
  List<Recipe> _recipes = [];

  List<Recipe> get recipes {
    return _recipes;
    //logica do filtro
  }

  set recipes(List<Recipe> value) {
    _recipes = value;
  }

  String _filtro = "";

  String get filtro => _filtro;

  set filtro(String value) {
    _filtro = value;
  }

}