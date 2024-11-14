import 'package:desafio_konsi/routes.g.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<int> pageIndex = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            pageIndex.value = index;

            if (pageIndex.value == 0) {
              Routefly.navigate(routePaths.home.maps);
            }
            if (pageIndex.value == 1) {
              Routefly.navigate(routePaths.home.locations);
            }
          },
          indicatorColor: Colors.amber,
          selectedIndex: pageIndex.value,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.map),
              label: 'Mapa',
            ),
            NavigationDestination(
              icon: Badge(child: Icon(Icons.book)),
              label: 'Caderneta',
            ),
          ],
        ),
        body: const RouterOutlet());
  }
}
