import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'venta_al_mundo_page.dart';
import 'list_poi.dart';
import 'favorite_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);


  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(""),
        backgroundColor:  Colors.white12,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: IndexedStack(
        index: selectedTab,
        children: const <Widget>[
          ListPoi(),
          FavPage(),
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

        ],
      ),
    );
  }
}