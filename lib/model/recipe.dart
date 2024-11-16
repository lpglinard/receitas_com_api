class Recipe {
  final int id;
  final String title;
  final String image;
  final int? servings;
  final int? readyInMinutes;
  final List<String> ingredients;
  final String? instructions;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    this.servings,
    this.readyInMinutes,
    required this.ingredients,
    this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      image: json['image'] ?? '',
      servings: json['servings'],
      readyInMinutes: json['readyInMinutes'],
      ingredients: (json['extendedIngredients'] as List<dynamic>?)
          ?.map((item) => item['original'].toString())
          .toList() ??
          [],
      instructions: json['instructions'] as String?,
    );
  }
}
