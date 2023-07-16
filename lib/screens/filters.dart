import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/Widgets/main_drawer.dart';
import 'package:meals_app/screens/tabs.dart';

enum Filter {
  glutonfree,
  lactosefree,
  vegetarian,
  vegan,
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});
  @override
  State<FilterScreen> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenfreefilterset = false;
  var _lactosefreefilterset = false;
  var _vegetarianfilterset = false;
  var _veganfilterset = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Filters',
        ),
      ),
      // drawer: MainDrawer(onselectscreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (ctx) => const TabScreen(),
      //       ),
      //     );
      //   }
      // }),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(
            {
              Filter.glutonfree: _glutenfreefilterset,
              Filter.lactosefree: _lactosefreefilterset,
              Filter.vegetarian: _vegetarianfilterset,
              Filter.vegan: _veganfilterset,
            },
          );
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              title: Text(
                'Gluteen-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include Gluteen free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ),
              value: _glutenfreefilterset,
              onChanged: (isChecked) {
                setState(() {
                  _glutenfreefilterset = isChecked;
                });
              },
            ),
            SwitchListTile(
              title: Text(
                'Lactose-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include Lactose free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ),
              value: _lactosefreefilterset,
              onChanged: (isChecked) {
                setState(() {
                  _lactosefreefilterset = isChecked;
                });
              },
            ),
            SwitchListTile(
              title: Text(
                'Veg Only',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include Vegetarian meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ),
              value: _vegetarianfilterset,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianfilterset = isChecked;
                });
              },
            ),
            SwitchListTile(
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include Vegan meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ),
              value: _veganfilterset,
              onChanged: (isChecked) {
                setState(() {
                  _veganfilterset = isChecked;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
