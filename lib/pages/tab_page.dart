import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visit_me/pages/profile_user.dart';
import 'favorite_page.dart';
import 'list_poi.dart';

class TabPage extends StatefulWidget {
  final tab;
  const TabPage({Key? key,this.tab});


  @override
  State<TabPage> createState() => TabPageState();
}

class TabPageState extends State<TabPage> {
  int selectedTab = 0;

  void initState(){
    widget.tab == null? null: selectedTab =widget.tab;
    super.initState();
  }

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