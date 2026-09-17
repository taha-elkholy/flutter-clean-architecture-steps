import 'package:equatable/equatable.dart';

class RecipeEntity extends Equatable {
  const RecipeEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.cuisine,
    required this.difficulty,
  });

  final int id;
  final String name;
  final String image;
  final double rating;
  final String cuisine;
  final String difficulty;

  @override
  List<Object?> get props => [id, name, image, rating, cuisine, difficulty];
}
