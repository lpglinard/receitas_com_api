import 'package:flutter/material.dart';

class ResultsList extends StatelessWidget {
  final List<String> recipes;

  ResultsList({required this.recipes});

  @override
  Widget build(BuildContext context) {
    if (recipes.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'No recipes found.',
          style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            recipes[index],
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          leading: Icon(Icons.food_bank),
        );
      },
    );
  }
}
