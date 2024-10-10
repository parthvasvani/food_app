import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  
  final void Function(String identifier) onSelectScreen;
  
  const MainDrawer({super.key, required this.onSelectScreen});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.tertiary.withOpacity(.60),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fastfood,
                    size: 48,
                    color: Theme.of(context).colorScheme.onTertiaryFixed,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                      "Cooking Up !",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onTertiaryFixed
                    ),
                  )
                ],
              )),
          ListTile(
            hoverColor: Colors.blue,
            onTap: () {
              onSelectScreen("Food");
            },
            leading: Icon(Icons.restaurant, size: 26, color: Theme.of(context).colorScheme.onTertiaryFixed,),
            title: Text("Food", style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onTertiaryFixed,
              fontSize: 24
            ),),
          ),
          ListTile(
            hoverColor: Colors.blue,
            onTap: () {
              onSelectScreen("Filters");
            },
            leading: Icon(Icons.restaurant, size: 26, color: Theme.of(context).colorScheme.onTertiaryFixed,),
            title: Text("Filters", style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onTertiaryFixed,
                fontSize: 24
            ),),
          )
        ],
      ),
    );
  }
}
