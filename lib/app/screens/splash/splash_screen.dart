import 'package:desafio_konsi/app/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() async {
    await Future.delayed(const Duration(seconds: 3));
    if (context.mounted) {
      context.go('/maps');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryColor,
      child: Center(
        child: Image.asset(
          'assets/gifs/splash.gif',
        ).animate(onComplete: (controller) => controller.repeat()),
      ),
    );
  }
}
