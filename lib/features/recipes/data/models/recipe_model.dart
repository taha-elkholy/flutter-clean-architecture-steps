class RecipeModel {
  const RecipeModel({
    this.id,
    this.name,
    this.image,
    this.rating,
    this.cuisine,
    this.difficulty,
  });

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      id: map['id'] as int?,
      name: map['name'] as String?,
      image: map['image'] as String?,
      rating: (map['rating'] as num?)?.toDouble(),
      cuisine: map['cuisine'] as String?,
      difficulty: map['difficulty'] as String?,
    );
  }

  final int? id;
  final String? name;
  final String? image;
  final double? rating;
  final String? cuisine;
  final String? difficulty;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'rating': rating,
      'cuisine': cuisine,
      'difficulty': difficulty,
    };
  }
}
