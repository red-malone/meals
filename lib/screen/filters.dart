import 'package:flutter/material.dart';

// import 'package:meals/screen/tabs.dart';
// import 'package:meals/widgets/main_drawer.dart';
enum Filter { glutenfree, lactosefree, vegetarian, vegan }

class FilterPage extends StatefulWidget {
  const FilterPage({super.key,required this.currentfilter});
  final Map<Filter,bool>currentfilter;

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  var _glutenfreefitler = false;
  var _lactosefreefitler = false;
  var _vegetarianfreefitler = false;
  var _veganfitler = false;

  @override
  void initState() {
    super.initState();
    _glutenfreefitler = widget.currentfilter[Filter.glutenfree]!;
    _lactosefreefitler = widget.currentfilter[Filter.lactosefree]!;
    _vegetarianfreefitler = widget.currentfilter[Filter.vegetarian]!;
    _veganfitler = widget.currentfilter[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter"),
      ),
      // drawer: MainDrawer(
      //   onpressed: (screen) {
      //     Navigator.of(context).pop();
      //     if (screen == 'Meals') {
      //       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const TabsScreen()));
      //     }
      //   },
      // ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenfree: _glutenfreefitler,
            Filter.lactosefree: _lactosefreefitler,
            Filter.vegetarian: _vegetarianfreefitler,
            Filter.vegan: _veganfitler,
          });
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenfreefitler,
              onChanged: (isChecked) {
                setState(() {
                  _glutenfreefitler = isChecked;
                });
              },
              title: Text(
                'Gluten Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Includes Gluten Free meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _lactosefreefitler,
              onChanged: (isChecked) {
                setState(() {
                  _lactosefreefitler = isChecked;
                });
              },
              title: Text(
                'Lactose Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Includes Lactose Free meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _vegetarianfreefitler,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianfreefitler = isChecked;
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Includes Vegetarian meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _veganfitler,
              onChanged: (isChecked) {
                setState(() {
                  _veganfitler = isChecked;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Includes Vegan meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
