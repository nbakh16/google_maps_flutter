
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final GoogleMapController _googleMapController;

  final Location _location = Location();
  LatLng? _currentLocation;

  late Marker _marker;
  final List<LatLng> _latLngList = [];
  final Set<Polyline> _polyLineSet = {};

  @override
  void initState() {
    listenToCurrentLocation();
    super.initState();
  }

  void listenToCurrentLocation() {
    _location.requestPermission();

    _location.hasPermission().then((value) {
      if(value == PermissionStatus.granted) {
        _location.changeSettings(interval: 10000);

        _location.onLocationChanged.listen((LocationData locationData) {
          _currentLocation = LatLng(locationData.latitude!, locationData.longitude!);

          _updateMarker();
          _updatePolyline();
          setState(() {});
        });
      }
    });
  }

  void _updateMarker() {
    _marker = Marker(
      markerId: const MarkerId('current_location'),
      position: _currentLocation!,
      infoWindow: InfoWindow(
        title: 'My current location',
        snippet: 'Lat: ${_currentLocation!.latitude}, Lng: ${_currentLocation!.longitude}',
      ),
      onTap: () {
        _googleMapController
            .showMarkerInfoWindow(const MarkerId('current_location'));
      },
    );
  }

  void _updatePolyline() {
    _latLngList.add(_currentLocation!);
    _polyLineSet.add(Polyline(
      polylineId: const PolylineId('polyline_list'),
      points: _latLngList,
      color: Colors.lightGreen,
      width: 6,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map'),),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _googleMapController = controller;
          _googleMapController.animateCamera(CameraUpdate.newLatLng(_currentLocation!));
        },
        initialCameraPosition: CameraPosition(
            zoom: 15,
            target: _currentLocation!
        ),
        markers: {_marker},
        polylines: _polyLineSet,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onTap: (LatLng? latLng) {
          print(latLng);
        },
      ),
    );
  }
}
