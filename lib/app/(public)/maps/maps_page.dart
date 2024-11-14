import 'package:desafio_konsi/app/(public)/interactors/controllers/locations_controller.dart';
import 'package:desafio_konsi/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late final LocationsControllerImpl controller;

  @override
  void initState() {
    super.initState();
    controller = injector.get<LocationsControllerImpl>();
    controller.addListener(listener);
  }

  void listener() {}

  @override
  void dispose() {
    controller.removeListener(listener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, state, child) {
          return FlutterMap(
            options: MapOptions(
              initialCenter:
                  LatLng(51.509364, -0.128928), // Center the map over London
              initialZoom: 9.2,
            ),
            children: [
              TileLayer(
                // Display map tiles from any source
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
                userAgentPackageName: 'com.example.app',
                // And many more recommended properties!
              ),
              RichAttributionWidget(
                // Include a stylish prebuilt attribution widget that meets all requirments
                attributions: [
                  // TextSourceAttribution(
                  //   'OpenStreetMap contributors',
                  //   onTap: () => launchUrl(Uri.parse(
                  //       'https://openstreetmap.org/copyright')), // (external)
                  // ),
                  // Also add images...
                ],
              ),
            ],
          );
        });
  }
}
