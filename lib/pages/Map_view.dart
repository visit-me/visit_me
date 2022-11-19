import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
final ListBox = GetStorage();
final ListPlace = ListBox.read('MapPlace').asMap();



class MapView extends StatefulWidget {
  final p;
  const MapView({super.key, this.p});

  @override
  State <MapView> createState() => new MapViewState();
}



class MapViewState  extends State<MapView> {

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final lat = ListPlace[widget.p]['latitude'];
    final lon = ListPlace[widget.p]['longitude'];
    final adr = ListPlace[widget.p]['address'];

    final LatLng _center = LatLng(lat, lon);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(ListPlace[widget.p]['title'], textScaleFactor: 1.2,style: TextStyle(color: Colors.black87),),
            backgroundColor: Colors.white38,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
          ),

        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 14.0,
          ),
        ),


          floatingActionButton: FloatingActionButton.extended (
            elevation: 4.0,
            icon: const Icon(Icons.fmd_good),
            label: const Text('ir'),
            onPressed: () {},
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          bottomNavigationBar: BottomAppBar(
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(icon: Icon(Icons.arrow_back_ios_sharp), onPressed: () {Navigator.pop(context);},),
                /*PopupMenuButton(
                  icon: Icon(Icons.share),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text("Facebook"),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text("Instagram"),
                    ),
                  ],
                ),
                IconButton(icon: Icon(Icons.email), onPressed: () {},),*/

              ],
            ),
          )
      ),
    );
  }
}

class BottomBarMap extends StatelessWidget {
  BottomBarMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}