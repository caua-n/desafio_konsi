import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:desafio_konsi/app/screens/revision/interactors/dtos/revision_dto.dart';
import 'package:desafio_konsi/app/screens/shell/favorites/interactors/controllers/favorites_controller.dart';
import 'package:desafio_konsi/app/screens/shell/favorites/interactors/states/favorites_state.dart';
import 'package:desafio_konsi/app/screens/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:desafio_konsi/app/core/services/get_it/service_locator.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late final FavoritesControllerImpl controller;

  @override
  void initState() {
    super.initState();
    controller = sl<FavoritesControllerImpl>();
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
              InitialState() => const Center(
                  child: CircularProgressIndicator(),
                ),
              LoadedFavoritesState(:final listLocationsEntity) =>
                CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: SearchWidget(
                        controller: controller.searchInput,
                        onChanged: (value) {
                          controller.filterLocations(value);
                        },
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                            childCount: listLocationsEntity.length,
                            (BuildContext context, int index) {
                      final location = listLocationsEntity[index];
                      return Slidable(
                        key: ValueKey(location.street),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                context.pushNamed(
                                  'revision',
                                  extra: RevisionDto(
                                      location: location,
                                      type: RevisionType.update),
                                );
                              },
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Editar',
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                controller.deleteLocation(location.id ?? 0);
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Excluir',
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(location.postalCode),
                          subtitle: Text(location.complement ?? ''),
                        ),
                      );
                    }))
                  ],
                ),
              ErrorState(:final exception) =>
                Center(child: Text('Erro: $exception')),
              _ => Center(child: Text('Estado desconhecido: $state')),
            };
          }),
    );
  }
}
//controller.deleteLocation(location.id ?? 0);