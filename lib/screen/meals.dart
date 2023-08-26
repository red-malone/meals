import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';

class MealsPage extends StatelessWidget {
  const MealsPage({super.key, required this.title, required this.meals});
  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        return Text(meals[index].title,style: const TextStyle(color: Colors.white),);
      },
    );

    if (meals.isEmpty) {
      return Center(
        child: Column(
          children: [
            Text("No meals found!", style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            ),
            const SizedBox(height: 20),
            Text("Try changing your filters.",
            style:Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            )
            ),
          ],
        ),
      );

    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: content,
    );
  }
}
