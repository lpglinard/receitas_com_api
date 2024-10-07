import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final TextEditingController searchController;
  final String hintText;

  SearchBox({required this.searchController, this.hintText = 'Search...'});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
