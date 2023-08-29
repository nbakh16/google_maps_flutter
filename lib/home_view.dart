import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map'),),
      body: const GoogleMap(
        initialCameraPosition: CameraPosition(
          zoom: 15,
          target: LatLng(24.250151813382207, 89.92231210838047)
        ),
      ),
    );
  }
}
