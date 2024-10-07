import 'package:flutter/material.dart';

import '../components/results_list.dart';
import '../components/search_box.dart';
import '../model/mock_data.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  List<String> _filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    _filteredRecipes = recipes;  // Use imported recipes
    _searchController.addListener(_filterRecipes);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterRecipes() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredRecipes = recipes.where((recipe) {
        return recipe.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFFF3E0), // Background color for the body
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 160.0,
              floating: false,
              pinned: true,
              snap: false,
              backgroundColor: Color(0xFFFFA736),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Center(
                  child: Text(
                    'RecipeIt',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                child: Column(
                  children: [
                    SearchBox(searchController: _searchController),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ResultsList(recipes: _filteredRecipes),
            ),
          ],
        ),
      ),
    );
  }
}
