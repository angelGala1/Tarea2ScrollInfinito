import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scrolinfinitos/features/presentation/pages/home_page.dart';

import '../../features/presentation/pages/splash_page.dart';

class AppRoutes {
  // Nombres de rutas
  static const String splash = '/';
  static const String home = '/home';

  // Configuración del router
  static final GoRouter router = GoRouter(
    initialLocation: splash,
    debugLogDiagnostics: true,

    // Manejo de errores
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),

    // Rutas
    routes: [
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),

      GoRoute(
        path: home,
        name: 'home',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),


    ],

  );
}