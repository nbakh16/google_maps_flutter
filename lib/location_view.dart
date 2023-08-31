import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {

  @override
  void initState() {
    // getMyLocation();
    listenToMyLocation();
    super.initState();
  }

  LocationData? myLocation;
  void getMyLocation() async {
    myLocation = await Location.instance.getLocation();
    setState(() {});
  }

  void listenToMyLocation() {
    Location.instance.onLocationChanged.listen((location) {
      if(location != myLocation) {
        myLocation = location;
        setState(() {

        });
        print('listening to location: $location');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Location'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${myLocation?.latitude} - ${myLocation?.longitude}', style: TextStyle(fontWeight: FontWeight.bold),),
            Text('accuracy: ${myLocation?.accuracy}'),
            Text('altitude: ${myLocation?.altitude}'),
          ],
        ),
      ),
    );
  }
}
