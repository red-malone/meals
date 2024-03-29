import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screen/meal_deets.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsPage extends StatelessWidget {
  const MealsPage({super.key, this.title, required this.meals});
  final String? title;
  final List<Meal> meals;

  void selectmeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealDetailScreen(
          meal: meal,
          ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        return MealItem(
          meal: meals[index],
          onSelect: (meal) {
            selectmeal(context, meal);
          },
        );
      },
    );

    if (meals.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No meals found!",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: 20),
            Text("Try changing your filters.",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
