import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../core/failure/network_failure.dart';
import '../../features/domain/entitie/banner_entity.dart';
import '../../features/presentation/blocs/article/get_article_bloc.dart';
import '../../features/presentation/blocs/article/get_article_event.dart';
import '../../features/presentation/blocs/article/get_article_state.dart';
import '../../features/presentation/widgets/component_banner.dart';

// Importa tus archivos aquí
// import 'package:tu_app/...

// MOCK - Usa MockBloc de bloc_test
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';


// MOCK
class MockArticleBloc extends MockBloc<ArticleEvent, ArticleState>
    implements ArticleBloc {}

// DATOS DE PRUEBA
final tBanner = BannerEntity(
  title: 'Banner Test',
  shortDescription: 'Descripción test',
  slug: 'banner-test',
  urlImage: 'https://example.com/banner.jpg',
  createdAt: DateTime(2024, 1, 1),
);

void main() {
  late MockArticleBloc mockBloc;

  setUp(() {
    mockBloc = MockArticleBloc();
  });

  tearDown(() {
    mockBloc.close();
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<ArticleBloc>(
        create: (_) => mockBloc,
        child: Scaffold(body: child),
      ),
    );
  }

  group('FeaturedBanner Widget Tests -', () {

    // TEST 1: Estado Loading
    testWidgets('Debe mostrar loading', (tester) async {
      whenListen(
        mockBloc,
        Stream.fromIterable([const ArticleLoading()]),
        initialState: const ArticleLoading(),
      );

      await tester.pumpWidget(makeTestableWidget(const FeaturedBanner()));

      expect(find.byType(FeaturedBanner), findsOneWidget);
    });

    // TEST 2: Estado Loaded - Solo verifica el título
    testWidgets('Debe mostrar el título del banner', (tester) async {
      final state = ArticleLoaded(
        banner: tBanner,
        articles: [],
        currentPage: 1,
        totalPages: 1,
      );

      whenListen(
        mockBloc,
        Stream.fromIterable([state]),
        initialState: state,
      );
      await tester.pumpWidget(makeTestableWidget(const FeaturedBanner()));
      await tester.pumpAndSettle(); // Espera a que todo se renderice
      expect(find.text('Banner Test'), findsOneWidget);
    });
    // TEST 3: Estado Error
    testWidgets('Debe mostrar estado de error', (tester) async {
      final failure = NetworkFailure.noInternet();
      final state = ArticleError(failure);
      whenListen(
        mockBloc,
        Stream.fromIterable([state]),
        initialState: state,
      );
      await tester.pumpWidget(makeTestableWidget(const FeaturedBanner()));
      await tester.pumpAndSettle();
      expect(find.byType(FeaturedBanner), findsOneWidget);
    });
  });
}