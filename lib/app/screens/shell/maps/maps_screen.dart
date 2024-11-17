import 'package:desafio_konsi/app/core/services/service_locator.dart';
import 'package:desafio_konsi/app/screens/shell/maps/interactors/controllers/maps_controller.dart';
import 'package:desafio_konsi/main.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/get_locations_usecase.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late final MapsController controller;

  @override
  void initState() {
    super.initState();
    controller = sl<MapsController>();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps Screen'),
      ),
      body: FutureBuilder(
        future: getIt<GetLocationsUsecase>().call(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No locations available'));
          } else {
            // Dados de localização carregados com sucesso
            final locations = snapshot.data!;
            return FlutterMap(
              options: const MapOptions(
                initialCenter:
                    LatLng(51.509364, -0.128928), // Ponto inicial do mapa
                initialZoom: 9.2,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                RichAttributionWidget(
                  attributions: [
                    // TextSourceAttribution(
                    //   'OpenStreetMap contributors',
                    //   onTap: () => launchUrl(
                    //       Uri.parse('https://openstreetmap.org/copyright')),
                    // ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
