import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visit_me/pages/profile_user.dart';
import 'PlaceView.dart';
import 'list_poi.dart';
import 'favorite_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);


  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  bool shadowColor = false;
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    // Mostrar barra superior (ocultar barra inferior)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    return Scaffold(
      body: IndexedStack(
        index: selectedTab,
        children:<Widget>[
          //ListPoi(),
          ListTileSelector(),
          FavPage(),
          LogCard(),

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
            icon: Icon(Icons.perm_identity_sharp),
            label: 'Perfil',
          ),

        ],
      ),
    );
  }
}