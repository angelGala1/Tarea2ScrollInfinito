import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/injection.dart';
import 'config/router/app_routes.dart';
import 'core/theme/theme.dart';
import 'features/presentation/blocs/article/get_article_bloc.dart';
import 'features/presentation/blocs/test/test_bloc.dart';
import 'features/presentation/pages/home_page.dart';

void main() async {
  // Asegurar inicialización de Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar dependencias
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // Proveer BLoCs globales aquí
      providers: [
        BlocProvider(create: (context) => sl<TesteoBloc>()),
        BlocProvider(create: (context) => sl<ArticleBloc>())

      ],
      child: MaterialApp.router(
        title: 'Scrool Infinito',
        debugShowCheckedModeBanner: false,

        // Tema
        theme: AppTheme.lightTheme(context),
        darkTheme: AppTheme.darkTheme(context),
        themeMode: ThemeMode.system,

        // Router
        routerConfig: AppRoutes.router,
      ),
    );
  }
}
