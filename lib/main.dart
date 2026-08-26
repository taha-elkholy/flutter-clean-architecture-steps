import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skeletonizer/skeletonizer.dart';

void main() {
  runApp(const RecipesApp());
}

class RecipesApp extends StatelessWidget {
  const RecipesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipes',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFBF8F4)),
      home: const HomePage(),
    );
  }
}

// Bouncing dots loader, used everywhere instead of CircularProgressIndicator.
class LoadingDots extends StatefulWidget {
  const LoadingDots({super.key, this.size = 9});
  final double size;

  @override
  State<LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            final t = (controller.value - i * 0.16) % 1.0;
            final bounce = math.sin(t * math.pi).clamp(0.0, 1.0);
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.size * 0.32),
              child: Transform.translate(
                offset: Offset(0, -bounce * widget.size),
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFFC8683B,
                    ).withValues(alpha: 0.3 + bounce * 0.7),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

// Shared image widget. Shows a shimmering placeholder while the image is
// downloading and a broken-image box if it fails. Stateless on purpose:
// Image.network already knows whether it's still loading, so tracking that
// manually only creates stale-state bugs when grid items get reused.
class NetworkImageWithShimmer extends StatelessWidget {
  const NetworkImageWithShimmer({
    required this.imageUrl,
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  Widget _placeholder({Widget? child}) {
    return Container(
      width: width,
      height: height,
      color: const Color(0xFFEFE7DC),
      child: child == null ? null : Center(child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return _placeholder();
    }
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return _placeholder(
          child: const Icon(
            Icons.broken_image_outlined,
            color: Color(0xFFA08F76),
          ),
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        // null progress means the image is fully loaded (including when it
        // came straight from the cache).
        if (loadingProgress == null) return child;
        return Skeletonizer(
          child: _placeholder(child: const LoadingDots(size: 7)),
        );
      },
    );
  }
}

// Shared card UI for both the home grid and the search grid.
// Duplicated on purpose is avoided here for one widget only (the card),
// while the fetch logic itself still lives separately in each page's State
// — that duplication is intentional and left for a later branch.
Widget buildRecipeGridCard(dynamic recipe, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              fit: StackFit.expand,
              children: [
                NetworkImageWithShimmer(
                  imageUrl: recipe['image'] ?? '',
                  width: double.infinity,
                  height: double.infinity,
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          size: 10,
                          color: Color(0xFFB4501F),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${recipe['rating']}',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB4501F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          recipe['name'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2B2420),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '${recipe['cuisine']} \u00B7 ${recipe['difficulty']}',
          style: const TextStyle(fontSize: 10.5, color: Color(0xFFA08F76)),
        ),
      ],
    ),
  );
}

const recipeGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  childAspectRatio: 0.72,
);

dynamic placeholderRecipe(int id) => {
  'id': id,
  'name': 'Recipe name placeholder',
  'image': '',
  'rating': 4.5,
  'cuisine': 'Cuisine',
  'difficulty': 'Easy',
};

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> recipes = [];
  bool isLoading = true;
  bool isLoadingMore = false;
  int skip = 0;
  final int limit = 10;
  int total = 0;
  String sortBy = 'rating';
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    unawaited(fetchRecipes());
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100) {
        unawaited(loadMore());
      }
    });
  }

  Future<void> fetchRecipes() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(
      'https://dummyjson.com/recipes?limit=$limit&skip=0&sortBy=$sortBy&order=desc&select=name,image,rating,cuisine,difficulty',
    );
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    setState(() {
      recipes = data['recipes'];
      total = data['total'];
      skip = limit;
      isLoading = false;
    });
  }

  Future<void> loadMore() async {
    if (isLoadingMore || skip >= total) return;
    setState(() {
      isLoadingMore = true;
    });
    final url = Uri.parse(
      'https://dummyjson.com/recipes?limit=$limit&skip=$skip&sortBy=$sortBy&order=desc&select=name,image,rating,cuisine,difficulty',
    );
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    setState(() {
      recipes.addAll(data['recipes']);
      skip += limit;
      isLoadingMore = false;
    });
  }

  Future<void> refresh() async {
    final url = Uri.parse(
      'https://dummyjson.com/recipes?limit=$limit&skip=0&sortBy=$sortBy&order=desc&select=name,image,rating,cuisine,difficulty',
    );
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    setState(() {
      recipes = data['recipes'];
      total = data['total'];
      skip = limit;
    });
  }

  void changeSort(String value) {
    sortBy = value;
    unawaited(fetchRecipes());
  }

  void openDetails(dynamic recipe) {
    if (isLoading) return;
    unawaited(
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => DetailsPage(recipeId: recipe['id']),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF8F4),
        elevation: 0,
        title: const Text(
          'Recipes',
          style: TextStyle(
            color: Color(0xFF2B2420),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF7A6A55)),
            onPressed: () {
              unawaited(
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const SearchPage(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => changeSort('rating'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: sortBy == 'rating'
                          ? const Color(0xFFC8683B)
                          : Colors.transparent,
                      border: Border.all(color: const Color(0xFFE4D9C8)),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      'Top Rated',
                      style: TextStyle(
                        color: sortBy == 'rating'
                            ? Colors.white
                            : const Color(0xFF8A7A64),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => changeSort('reviewCount'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: sortBy == 'reviewCount'
                          ? const Color(0xFFC8683B)
                          : Colors.transparent,
                      border: Border.all(color: const Color(0xFFE4D9C8)),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      'Most Reviewed',
                      style: TextStyle(
                        color: sortBy == 'reviewCount'
                            ? Colors.white
                            : const Color(0xFF8A7A64),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: refresh,
              color: const Color(0xFFC8683B),
              backgroundColor: const Color(0xFFFBF8F4),
              child: Skeletonizer(
                enabled: isLoading,
                child: GridView.builder(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  gridDelegate: recipeGridDelegate,
                  itemCount: isLoading ? 6 : recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = isLoading
                        ? placeholderRecipe(index)
                        : recipes[index];
                    return buildRecipeGridCard(
                      recipe,
                      () => openDetails(recipe),
                    );
                  },
                ),
              ),
            ),
          ),
          if (isLoadingMore)
            const Padding(padding: EdgeInsets.all(12), child: LoadingDots()),
        ],
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();
  List<dynamic> results = [];
  bool isLoading = false;
  bool hasSearched = false;

  // NOTE: search only runs on submit (Enter) for now.
  // Live-as-you-type search needs debouncing, and that's a deliberate
  // problem left for a later branch, not an oversight here.
  Future<void> search(String query) async {
    if (query.isEmpty) return;
    setState(() {
      isLoading = true;
      hasSearched = true;
    });

    final url = Uri.parse(
      'https://dummyjson.com/recipes/search?q=$query&select=name,image,rating,cuisine,difficulty',
    );
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    setState(() {
      results = data['recipes'];
      isLoading = false;
    });
  }

  void openDetails(dynamic recipe) {
    if (isLoading) return;
    unawaited(
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => DetailsPage(recipeId: recipe['id']),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF8F4),
        elevation: 0,
        title: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search recipes...',
            border: InputBorder.none,
          ),
          onSubmitted: search,
        ),
      ),
      body: !hasSearched
          ? const Center(
              child: Text(
                'Type a recipe name and hit enter',
                style: TextStyle(color: Color(0xFFA08F76)),
              ),
            )
          : Skeletonizer(
              enabled: isLoading,
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: recipeGridDelegate,
                itemCount: isLoading ? 6 : results.length,
                itemBuilder: (context, index) {
                  final recipe = isLoading
                      ? placeholderRecipe(index)
                      : results[index];
                  return buildRecipeGridCard(recipe, () => openDetails(recipe));
                },
              ),
            ),
    );
  }
}

class DetailsPage extends StatefulWidget {
  const DetailsPage({required this.recipeId, super.key});
  final int recipeId;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  dynamic recipe;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    unawaited(fetchDetails());
  }

  Future<void> fetchDetails() async {
    final url = Uri.parse('https://dummyjson.com/recipes/${widget.recipeId}');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    setState(() {
      recipe = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F4),
      appBar: AppBar(backgroundColor: const Color(0xFFFBF8F4), elevation: 0),
      body: isLoading
          ? const Center(child: LoadingDots())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: NetworkImageWithShimmer(
                      imageUrl: recipe['image'] ?? '',
                      width: double.infinity,
                      height: 220,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    recipe['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2B2420),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${recipe['cuisine']} \u00B7 '
                    '${recipe['difficulty']} \u00B7 '
                    "${recipe['caloriesPerServing']} cal",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFFA08F76),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Ingredients',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2B2420),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(
                    recipe['ingredients'].length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text('\u2022 ${recipe['ingredients'][index]}'),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Instructions',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2B2420),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(
                    recipe['instructions'].length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        '${index + 1}. ${recipe['instructions'][index]}',
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
