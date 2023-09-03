import 'package:flutter/material.dart';
import 'package:meals/data/dummy.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screen/categories.dart';
import 'package:meals/screen/filters.dart';
import 'package:meals/screen/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kInitialFilters = {
  Filter.glutenfree: false,
  Filter.lactosefree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedpageindex = 0;
  final List<Meal> _favmeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showinfomessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _togglefavmeal(Meal meal) {
    final existing = _favmeals.contains(meal);
    if (existing) {
      setState(() {
        _favmeals.remove(meal);
        _showinfomessage("Meal removed");
      });
    } else {
      setState(() {
        _favmeals.add(meal);
        _showinfomessage("Meal added");
      });
    }
  }

  void _selectedIndex(int val) {
    setState(() {
      _selectedpageindex = val;
    });
  }

  void _setscreen(String screen) async {
    Navigator.of(context).pop();
    if (screen == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: ((context) => FilterPage(currentfilter: _selectedFilters,)),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals =ref.watch(mealsProvider);
    final availablemeal = meals.where((meal) {
      if (_selectedFilters[Filter.glutenfree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactosefree]! && !meal.isLactoseFree) {
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
    Widget active = CategoriesPage(
      ontoggleliked: _togglefavmeal,
      available: availablemeal,
    );
    var pagetitle = 'Categories';
    if (_selectedpageindex == 1) {
      active = MealsPage(
        meals: _favmeals,
        ontoggleliked: _togglefavmeal,
      );
      pagetitle = 'Your Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(pagetitle),
      ),
      drawer: MainDrawer(
        onpressed: _setscreen,
      ),
      body: active,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedIndex,
        currentIndex: _selectedpageindex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
        ],
      ),
    );
  }
}
