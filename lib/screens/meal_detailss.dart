import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
// import 'package:transparent_image/transparent_image.dart';

class MealDetailssScreen extends StatefulWidget {
  const MealDetailssScreen({
    super.key,
    required this.meal,
    required this.onToggleFavorite,
    required this.favMeals,
  });

  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> favMeals;

  @override
  State<MealDetailssScreen> createState() {
    return _MealDetailsScreen();
  }
}

class _MealDetailsScreen extends State<MealDetailssScreen> {
  @override
  Widget build(context) {
    // Widget content = FadeInImage(
    //   placeholder: MemoryImage(kTransparentImage),
    //   image: NetworkImage(meal.imageUrl),
    //   fit: BoxFit.cover,
    //   height: 200,
    //   width: double.infinity,
    // );

    var isFav = false;
    var favoriteIcon = widget.favMeals.contains(widget.meal)
        ? const Icon(Icons.star)
        : const Icon(Icons.star_border);

    void setStarIcon() {
      isFav = !isFav;
      if (isFav) {
        setState(() {
          favoriteIcon = const Icon(Icons.star);
        });
      } else {
        setState(() {
          favoriteIcon = const Icon(Icons.star_border);
        });
      }
    }

    Widget content = SingleChildScrollView(
      child: Column(
        children: [
          Image.network(
            widget.meal.imageUrl,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            'Ingredients',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 14,
          ),
          for (final ingredient in widget.meal.ingredients)
            Text(
              ingredient,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          const SizedBox(
            height: 24,
          ),
          Text(
            'Steps',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          ),
          for (final step in widget.meal.steps)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              child: Text(
                "\u2022  $step",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.title),
        actions: [
          IconButton(
            // onPressed: () => widget.onToggleFavorite(widget.meal),
            onPressed: () {
              setStarIcon();
              widget.onToggleFavorite(widget.meal);
            },
            icon: favoriteIcon,
          ),
        ],
      ),
      body: content,
    );
  }
}
