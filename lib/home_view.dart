import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final GoogleMapController _googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map'),),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          zoom: 15,
          target: LatLng(24.250151813382207, 89.92231210838047)
        ),
        onMapCreated: (GoogleMapController controller) {
          _googleMapController = controller;
        },
        onTap: (LatLng? latLng) {
          print(latLng);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: <Marker>{
          Marker(
            markerId: MarkerId('custom-marker'),
            position: LatLng(24.248005761996964, 89.92045372724533),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
            infoWindow: InfoWindow(title: 'Cutom Title', snippet: 'Snippet'),
            draggable: true,

          ),
          Marker(
            markerId: MarkerId('custom-marker-1'),
            position: LatLng(24.240005761996964, 89.91045372724533),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
            infoWindow: InfoWindow(title: 'Cutom Title', snippet: 'Snippet'),
            draggable: true,

          ),
          Marker(
            markerId: MarkerId('custom-marker-2'),
            position: LatLng(24.24123286823403, 89.92040444165468),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
            infoWindow: InfoWindow(title: 'Cutom Title', snippet: 'Snippet'),
            draggable: true,

          ),
        },
        polylines: <Polyline>{
          Polyline(
            polylineId: PolylineId('custom-polyline'),
            points: <LatLng>[
              LatLng(24.248005761996964, 89.92045372724533),
              LatLng(24.240005761996964, 89.91045372724533),
              LatLng(24.24123286823403, 89.92040444165468)
            ],
            width: 4,
            color: Colors.white,
            jointType: JointType.round
          ),
        },
        circles: <Circle>{
          Circle(
              circleId: CircleId('custom-circle'),
              center: LatLng(24.240005761996964, 89.91045372724533),
              radius: 250,
              strokeColor: Colors.amber,
              fillColor: Colors.amber.withOpacity(0.25)
          )
        },
        polygons: <Polygon>{
          Polygon(
            polygonId: PolygonId('custom-polygon'),
            points: <LatLng>[
              LatLng(24.248005761996964, 89.92045372724533),
              LatLng(24.240005761996964, 89.91045372724533),
              LatLng(24.24123286823403, 89.92040444165468)
            ],
            fillColor: Colors.green,
            strokeWidth: 20,
            strokeColor:  Colors.green
          )
        },
      ),
    );
  }
}
