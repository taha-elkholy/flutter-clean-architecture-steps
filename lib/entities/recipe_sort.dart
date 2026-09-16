/// The two sort options the recipe list can be ordered by.
///
/// Each carries its own API value, so call sites never map one to the other.
enum RecipeSort {
  topRated('rating'),
  mostReviewed('reviewCount');

  const RecipeSort(this.queryValue);

  /// The value sent to the API as `sortBy`.
  final String queryValue;
}
