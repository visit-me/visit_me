import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:visit_me/pages/PlaceView.dart';
import 'package:visit_me/pages/tab_page.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'locations.dart' as locations;
final ListBox = GetStorage();
final ListPlace = ListBox.read('MapPlace');

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State <MapView> createState() => new MapViewState();
}

class MapViewState  extends State<MapView> {

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
            title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "VISIT-ME",
                      )])),
     body: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);


  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }


}