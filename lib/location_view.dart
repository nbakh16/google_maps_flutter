import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {

  LocationData? myCurrentLocation;
  StreamSubscription? _locationSubscription;

  @override
  void initState() {
    locationInitialSettings();
    super.initState();
  }

  void locationInitialSettings() {
    Location.instance.requestPermission();

    Location.instance.hasPermission().then((value) {
      if(value == PermissionStatus.granted) {
        Location.instance.changeSettings(
          accuracy: LocationAccuracy.low,
          distanceFilter: 25,
          interval: 50000
        );
      }
    });
  }

  void getMyCurrentLocation() async {
    myCurrentLocation = await Location.instance.getLocation();
    setState(() {});
  }

  void listenToMyLocation() {
    _locationSubscription = Location.instance.onLocationChanged.listen((location) {
      if(location != myCurrentLocation) {
        myCurrentLocation = location;
        setState(() {});
        print('listening to location: $location');
      }
    });
  }

  void stopListenToMyLocation() {
    _locationSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Location'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${myCurrentLocation?.latitude} - ${myCurrentLocation?.longitude}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('accuracy: ${myCurrentLocation?.accuracy}'),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <FloatingActionButton>[
          FloatingActionButton(onPressed: getMyCurrentLocation, child: const Icon(Icons.my_location),),
          FloatingActionButton(onPressed: listenToMyLocation, child: const Icon(Icons.location_on),),
          FloatingActionButton(onPressed: stopListenToMyLocation, child: const Icon(Icons.location_off),),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }
}
