import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

//using "k" infront of a variable's name means that it is a global variable (Flutter's syntax)
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

//ConsumerStatefulWidget is a statefulWidget provieded by the riverpod package which allow us to listen or modify the provider
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  //Creatig a map where key would be of type Filter and value would be of type bool
  Map<Filter, bool> _selectedFilters = kInitialFilters;

//index is automatically passed on click of one of the BottomNavigatioNBarItem
  void _selectPage(int index) => setState(() {
        _selectedPageIndex = index;
      });

//identifier is retured from the Main drawer file
  void _setScreen(String identifier) async {
    Navigator.of(context)
        .pop(); //popping because if we are already on meals screen so pop would just close the drawer else if we go to a different screen the drawer is not left open behind.
    if (identifier == 'filters') {
      //as push function returns a Future object that means that it expects some values in return hence we used await
      //as we are calling Filters Screen, it will return a map of key Filter and value bool which will tell which filter was applied by the user hence we are telling push what format to expect
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        //pushReplacement in place of push removes the back screen and hence the device back button will close the app
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //ref is a package provided by Provider which is used to watch any change on the provider and refresh the page
    final meals = ref.watch(mealsProvider);
    //filtering the meals according to the selected filters
    final availableMeals = meals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    //deciding the active screen based on index
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
    }

    //setting dynamic page title according to selected tabs
    var activePageTitle =
        _selectedPageIndex == 1 ? 'Your Favorites' : 'Categories';

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      // creates an element of bottom tabs which can be used to navigate to different screens
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        // if type is set fixed then we can add more than 3 items in bottomNavigationBar
        type: BottomNavigationBarType.fixed,
        //highlights the tab selected
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
