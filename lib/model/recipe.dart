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


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Recipe && other.id == id;
  }


  @override
  int get hashCode => id.hashCode;

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: _sanitizeText(json['title']),
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

  static String _sanitizeText(String text) {
    return text.replaceAll(RegExp(r'[^\x00-\x7F]'), '');
  }
}
