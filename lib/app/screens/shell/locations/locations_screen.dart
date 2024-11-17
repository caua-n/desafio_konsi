import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:desafio_konsi/app/screens/shell/locations/interactors/controllers/locations_controller.dart';
import 'package:desafio_konsi/app/screens/shell/locations/interactors/states/locations_state.dart';
import 'package:flutter/material.dart';
import 'package:desafio_konsi/app/core/services/service_locator.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  late final LocationsController controller;

  @override
  void initState() {
    super.initState();
    controller = sl<LocationsController>();
    controller.addListener(listener);
    controller.loadLocations();
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
        title: const Text('Locations Screen'),
      ),
      body: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, state, child) {
            return switch (state) {
              LoadedLocationsState(:final listLocationsEntity) => Center(
                  child: Container(
                      color: Colors.red,
                      width: 150,
                      height: 150,
                      child: Text(listLocationsEntity!.length.toString())),
                ),
              ErrorState(:final exception) =>
                Center(child: Text('Erro: $exception')),
              _ => Center(child: Text('Estado desconhecido: $state')),
            };
            // FutureBuilder<List<LocationEntity>>(
            //   future: _getLocationsUsecase(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(child: CircularProgressIndicator());
            //     } else if (snapshot.hasError) {
            //       return Center(child: Text('Error: ${snapshot.error}'));
            //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            //       return const Center(child: Text('No locations available'));
            //     } else {
            //       // Localizações carregadas com sucesso
            //       final locations = snapshot.data!;
            //       return ListView.builder(
            //         itemCount: locations.length,
            //         itemBuilder: (context, index) {
            //           final location = locations[index];
            //           return ListTile(
            //             leading:
            //                 const Icon(Icons.location_on, color: Colors.blue),
            //             title: Text(location.address),
            //             subtitle: Text(
            //               '${location.cep}, Número: ${location.addressNumber}${location.complement != null ? ', Complemento: ${location.complement}' : ''}',
            //             ),
            //             onTap: () {
            //               // Ação ao clicar em uma localização
            //               ScaffoldMessenger.of(context).showSnackBar(
            //                 SnackBar(
            //                   content: Text(
            //                       'Localização selecionada: ${location.address}'),
            //                 ),
            //               );
            //             },
            //           );
            //         },
            //       );
            //     }
            //   },
            // );
          }),
    );
  }
}
