import 'package:equatable/equatable.dart';

/// One recipe as the app uses it: nothing nullable, so no screen has to ask.
///
/// The gaps the server may leave are filled on the way in, not read around
/// here.
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
