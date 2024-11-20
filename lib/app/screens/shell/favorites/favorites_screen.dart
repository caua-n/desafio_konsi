import 'package:desafio_konsi/app/core/constants/colors.dart';
import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:desafio_konsi/app/screens/revision/interactors/dtos/revision_dto.dart';
import 'package:desafio_konsi/app/screens/shell/favorites/interactors/controllers/favorites_controller.dart';
import 'package:desafio_konsi/app/screens/shell/favorites/interactors/states/favorites_state.dart';
import 'package:desafio_konsi/app/screens/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:desafio_konsi/app/core/services/get_it/service_locator.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, state, child) {
              return switch (state) {
                LoadedFavoritesState(:final listLocationsEntity) =>
                  CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: SearchWidget(
                          keyboardType: TextInputType.number,
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
                                backgroundColor: AppColors.primaryColor,
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: 'Editar',
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  controller.deleteLocation(location.id ?? 0);
                                },
                                backgroundColor: Colors.transparent,
                                foregroundColor: AppColors.primaryColor,
                                icon: Icons.delete,
                                label: 'Excluir',
                              ),
                            ],
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    context.pushNamed(
                                      'revision',
                                      extra: RevisionDto(
                                          location: location,
                                          type: RevisionType.update),
                                    );
                                  },
                                  trailing: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: AppColors.lowGreenColor,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: SvgPicture.asset(
                                          'assets/svgs/bookmark.svg'),
                                    ),
                                  ),
                                  title: Text(
                                    location.postalCode,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: AppColors.mainTextColor),
                                  ),
                                  subtitle: Text(
                                    '${location.street} - ${location.neighbourhood}, ${location.city} - ${location.state}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: AppColors.secondaryTextColor),
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  color: const Color(0xffCAC4D0),
                                )
                              ],
                            ),
                          ),
                        );
                      }))
                    ],
                  ),
                EmptyFavoritesState() => CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: SearchWidget(
                          keyboardType: TextInputType.number,
                          controller: controller.searchInput,
                          onChanged: (value) {
                            controller.filterLocations(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ErrorState(:final exception) =>
                  Center(child: Text('Erro: $exception')),
                _ => Center(child: Text('Estado desconhecido: $state')),
              };
            }),
      ),
    );
  }
}
