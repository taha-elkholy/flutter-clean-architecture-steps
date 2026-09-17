class RecipeDetailsModel {
  const RecipeDetailsModel({
    this.id,
    this.name,
    this.image,
    this.rating,
    this.cuisine,
    this.difficulty,
    this.caloriesPerServing,
    this.prepTimeMinutes,
    this.cookTimeMinutes,
    this.servings,
    this.ingredients,
    this.instructions,
  });

  factory RecipeDetailsModel.fromMap(Map<String, dynamic> map) {
    return RecipeDetailsModel(
      id: map['id'] as int?,
      name: map['name'] as String?,
      image: map['image'] as String?,
      rating: (map['rating'] as num?)?.toDouble(),
      cuisine: map['cuisine'] as String?,
      difficulty: map['difficulty'] as String?,
      caloriesPerServing: map['caloriesPerServing'] as int?,
      prepTimeMinutes: map['prepTimeMinutes'] as int?,
      cookTimeMinutes: map['cookTimeMinutes'] as int?,
      servings: map['servings'] as int?,
      ingredients: (map['ingredients'] as List<dynamic>?)
          ?.map((ingredient) => ingredient as String?)
          .toList(),
      instructions: (map['instructions'] as List<dynamic>?)
          ?.map((instruction) => instruction as String?)
          .toList(),
    );
  }

  final int? id;
  final String? name;
  final String? image;
  final double? rating;
  final String? cuisine;
  final String? difficulty;
  final int? caloriesPerServing;
  final int? prepTimeMinutes;
  final int? cookTimeMinutes;
  final int? servings;
  final List<String?>? ingredients;
  final List<String?>? instructions;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'rating': rating,
      'cuisine': cuisine,
      'difficulty': difficulty,
      'caloriesPerServing': caloriesPerServing,
      'prepTimeMinutes': prepTimeMinutes,
      'cookTimeMinutes': cookTimeMinutes,
      'servings': servings,
      'ingredients': ingredients,
      'instructions': instructions,
    };
  }
}
