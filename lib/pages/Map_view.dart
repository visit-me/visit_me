import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
final ListBox = GetStorage();

class MapView extends StatefulWidget {
  final double lat;
  final double long;
  final String adr;
  final String title;
  const MapView({super.key,required this.lat, required this.long, required this.adr,required this.title});

  @override
  State <MapView> createState() => new MapViewState();
}



class MapViewState  extends State<MapView> {

  late GoogleMapController mapController;
  final Set<Marker> markers = new Set();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> getmarkers() { //markers to place on map
    setState(() {
      markers.add(Marker( //add first marker
        markerId: MarkerId(widget.title),
        position:LatLng(widget.lat, widget.long), //position of marker
        infoWindow: InfoWindow( //popup info
          title: widget.title,
          snippet: widget.adr,
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
    });

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    final LatLng _center = LatLng(widget.lat, widget.long);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(widget.title, textScaleFactor: 1.2,
            style: TextStyle(color: Colors.black87),),
          backgroundColor: Colors.white38,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),

        body: GoogleMap(
          onMapCreated: _onMapCreated,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 18.0,
          ),
          markers: getmarkers(),

        ),
      ),
    );
  }


}




