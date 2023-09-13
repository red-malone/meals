import 'package:flutter/material.dart';
import 'package:meals/data/dummy.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screen/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/model/category.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key, required this.available});

  final List<Meal> available;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filter = widget.available
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MealsPage(
            title: category.title,
            meals: filter,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          children: [
            for (final categories in availableCategories)
              CategoryGridItem(
                category: categories,
                onPressed: () {
                  _selectCategory(context, categories);
                },
              ),
          ],
        ),
        builder: (context, child) => SlideTransition(
          position: Tween(
            begin: const Offset(0, .3),
            end: const Offset(0, 0),
          ).animate(CurvedAnimation(parent: _animationController, curve: Curves.linearToEaseOut)),
          child: child,),);
  }
}
