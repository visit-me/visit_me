import 'package:flutter/material.dart';
import 'package:visit_me/pages/venta_al_mundo_page.dart';
import 'list_poi.dart';
import 'favorite_page.dart';

class TabPagecard extends StatefulWidget {
  const TabPagecard ({Key? key}) : super(key: key);

  @override
  State<TabPagecard> createState() => _TabPagecardState();
}

class _TabPagecardState extends State<TabPagecard> {
  int selectedTab = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedTab,
        children: const <Widget>[
          ListPoi(),
          FavPage(),
          HomePage()
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedTab,
        onDestinationSelected: (int index) {
          setState(() {
            selectedTab = index;
          });
        },
        animationDuration: const Duration(seconds: 2),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'Lugares',
            selectedIcon: Icon(Icons.list_outlined),
            tooltip: 'Lugares',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            label: 'Favoritos',
          ),
          NavigationDestination(
            icon: Icon(null),
            label: '',
          ),

        ],
      ),
    );
  }
}