import 'package:flutter/material.dart';
import 'package:meals/data/dummy.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screen/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/model/category.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key,required this.ontoggleliked});

  final void Function(Meal meal) ontoggleliked;

  void _selectCategory(BuildContext context, Category category) {
    final filter =dummyMeals.where((meal) => meal.categories.contains(category.id)).toList();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MealsPage(title:category.title, meals: filter,ontoggleliked: ontoggleliked,);
      },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
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
                _selectCategory(context,categories);
              },
            ),
        ],
      ),
    );
  }
}
