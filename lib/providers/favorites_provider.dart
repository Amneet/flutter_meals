import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

//StateNotifier is beneficial if state would change, else if static data, use Provider
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  //constructor, initializer list super, which has the initial value
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFav = state.contains(meal);

    //as we cant use add or remove here so we have to create a new list everytime
    if (mealIsFav) {
      //removing
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      //adding
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
