import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recipes_provider.dart';

class SearchBox extends StatelessWidget {
  final TextEditingController searchController;

  SearchBox({required this.searchController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: (value) {
        // Notify provider to search recipes
        if (value.isNotEmpty) {
          Provider.of<RecipeProvider>(context, listen: false)
              .searchRecipes(value);
        }
      },
      decoration: InputDecoration(
        hintText: 'Search recipes...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
