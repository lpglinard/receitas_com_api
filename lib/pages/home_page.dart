import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receitas_com_api/pages/favorites_page.dart';
import '../components/results_list.dart';
import '../components/search_box.dart';
import '../providers/recipes_provider.dart';
import '../model/recipe.dart';


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
    _filteredRecipes = "" as List<String>;
    _searchController.addListener(_filterRecipes);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterRecipes() {
    String query = _searchController.text;
    Provider.of<RecipeProvider>(context, listen: false).searchRecipes(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFFF3E0), // Background color for the body
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              actions: [
                IconButton(onPressed: () {
                  Navigator.of(context).pushNamed(FavoritesPage.routeName);
                }, icon: Icon(Icons.favorite_border))
              ],
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
              child: ResultsList(),
            ),
          ],
        ),
      ),
    );
  }
}
