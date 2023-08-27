import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screen/categories.dart';
import 'package:meals/screen/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedpageindex = 0;
  final List<Meal> _favmeals = [];

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

  @override
  Widget build(BuildContext context) {
    Widget active = CategoriesPage(
      ontoggleliked: _togglefavmeal,
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
      drawer: MainDrawer(),
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
