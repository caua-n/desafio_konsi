import 'package:desafio_konsi/app/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        elevation: 26.9,
        shadowColor: const Color(0xff000000),
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          _onItemTapped(index, context);
        },
        destinations: <Widget>[
          NavigationDestination(
            icon: SizedBox(
              height: 24,
              width: 24,
              child: SvgPicture.asset(
                'assets/svgs/maps.svg',
                colorFilter: ColorFilter.mode(
                  selectedIndex == 0
                      ? AppColors.primaryColor
                      : AppColors.subBlack,
                  BlendMode.srcIn,
                ),
              ),
            ),
            label: 'Mapa',
          ),
          NavigationDestination(
            icon: SizedBox(
              height: 24,
              width: 24,
              child: SvgPicture.asset(
                'assets/svgs/book.svg',
                colorFilter: ColorFilter.mode(
                  selectedIndex == 0
                      ? AppColors.subBlack
                      : AppColors.primaryColor, // Cor condicional
                  BlendMode.srcIn,
                ),
              ),
            ),
            label: 'Caderneta',
          ),
        ],
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String path = GoRouterState.of(context).uri.path;
    if (path.startsWith('/maps')) {
      return 0;
    }
    if (path.startsWith('/favorites')) {
      return 1;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/maps');
        break;
      case 1:
        context.go('/favorites');
        break;
    }
  }
}
