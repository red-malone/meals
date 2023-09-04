import 'package:flutter/material.dart';
import 'package:meals/providers/favourites_provider.dart';
import 'package:meals/providers/filters_provider.dart';
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

  void _selectedIndex(int val) {
    setState(() {
      _selectedpageindex = val;
    });
  }

  void _setscreen(String screen) async {
    Navigator.of(context).pop();
    if (screen == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: ((context) => const FilterPage()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availablemeal = ref.watch(filteredmeal);
    Widget active = CategoriesPage(
      available: availablemeal,
    );
    var pagetitle = 'Categories';
    if (_selectedpageindex == 1) {
      final favouriteMeals = ref.watch(favMealsProvider);
      active = MealsPage(
        meals: favouriteMeals,
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
