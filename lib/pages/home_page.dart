import 'package:flutter/material.dart';
import 'package:receitas_com_api/pages/favorites_page.dart';
import '../components/results_list.dart';
import '../components/search_box.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(FavoritesPage.routeName);
                  },
                  icon: Icon(Icons.favorite, color: Colors.red,),
                ),
              ),
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
            child: ResultsList(searchController: _searchController),
          ),
        ],
      ),
    );
  }
}
