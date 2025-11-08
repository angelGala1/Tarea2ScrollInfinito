import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../core/failure/network_failure.dart';
import '../../features/domain/entitie/article_entity.dart';
import '../../features/domain/entitie/article_response_entity.dart';
import '../../features/domain/entitie/banner_entity.dart';
import '../../features/domain/usecase/get_article.dart';
import '../../features/presentation/blocs/article/get_article_bloc.dart';
import '../../features/presentation/blocs/article/get_article_event.dart';
import '../../features/presentation/blocs/article/get_article_state.dart';

// MOCK
class MockGetArticlesUseCase extends Mock implements GetArticlesUseCase {}

// DATOS DE PRUEBA
final tBanner = BannerEntity(
  title: 'Banner Test',
  shortDescription: 'Descripción del banner',
  slug: 'banner-test',
  urlImage: 'https://example.com/banner.jpg',
  createdAt: DateTime(2024, 1, 1),
);

final tArticle = ArticleEntity(
  title: 'Artículo Test',
  shortDescription: 'Descripción del artículo',
  slug: 'articulo-test',
  urlImage: 'https://example.com/article.jpg',
  createdAt: DateTime(2024, 1, 1),
  status: true,
  typeChange: false,
);

final tArticleResponse = ArticleResponseEntity(
  error: false,
  status: 200,
  message: 'Success',
  banner: tBanner,
  articles: [tArticle],
  total: 50,
  rows: 10,
  from: 1,
  to: 10,
  pages: 5,
  pageSelected: 1,
);

void main() {
  late ArticleBloc bloc;
  late MockGetArticlesUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetArticlesUseCase();
    bloc = ArticleBloc(getArticlesUseCase: mockUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  group('ArticleBloc Tests -', () {

    // TEST 1: Estado inicial
    test('Estado inicial debe ser ArticleInitial', () {
      expect(bloc.state, const ArticleInitial());
    });

    // TEST 2: Cargar artículos exitosamente
    blocTest<ArticleBloc, ArticleState>(
      'Debe emitir [Loading, Loaded] cuando carga artículos con éxito',
      build: () {
        when(() => mockUseCase(page: 1)).thenAnswer(
              (_) async => Right(tArticleResponse),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadArticlesEvent()),
      expect: () => [
        const ArticleLoading(),
        isA<ArticleLoaded>(),
      ],
    );

    // TEST 3: Cargar artículos con error
    blocTest<ArticleBloc, ArticleState>(
      'Debe emitir [Loading, Error] cuando falla la carga',
      build: () {
        when(() => mockUseCase(page: 1)).thenAnswer(
              (_) async => Left(NetworkFailure.noInternet()),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadArticlesEvent()),
      expect: () => [
        const ArticleLoading(),
        isA<ArticleError>(),
      ],
    );
  });
}