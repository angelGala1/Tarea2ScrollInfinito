import 'package:flutter/cupertino.dart';

import '../../../domain/usecase/get_article.dart';
import 'get_article_event.dart';
import 'get_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticlesUseCase getArticlesUseCase;

  ArticleBloc({required this.getArticlesUseCase})
    : super(const ArticleInitial()) {
    on<LoadArticlesEvent>(_onLoadArticles);
    on<LoadMoreArticlesEvent>(_onLoadMoreArticles);
    on<RefreshArticlesEvent>(_onRefreshArticles);
    on<LoadPageEvent>(_onLoadPage); // 👈 ¡AGREGAR ESTA LÍNEA!
  }

  Future<void> _onLoadArticles(
    LoadArticlesEvent event,
    Emitter<ArticleState> emit,
  ) async {
    emit(const ArticleLoading());

    final result = await getArticlesUseCase(page: 1);

    result.fold(
      (failure) => emit(ArticleError(failure)),
      (response) => emit(
        ArticleLoaded(
          banner: response.banner,
          articles: response.articles,
          currentPage: response.pageSelected,
          totalPages: response.pages,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreArticles(
    LoadMoreArticlesEvent event,
    Emitter<ArticleState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ArticleLoaded) return;
    if (currentState.isLoadingMore) return;
    if (!currentState.hasMorePages) return;

    emit(currentState.copyWith(isLoadingMore: true));

    final nextPage = currentState.currentPage + 1;
    final result = await getArticlesUseCase(page: nextPage);

    result.fold(
      (failure) => emit(currentState.copyWith(isLoadingMore: false)),
      (response) {
        final updatedArticles = [
          ...currentState.articles,
          ...response.articles,
        ];
        emit(
          ArticleLoaded(
            banner: currentState.banner,
            articles: updatedArticles,
            currentPage: response.pageSelected,
            totalPages: response.pages,
          ),
        );
      },
    );
  }

  Future<void> _onRefreshArticles(
    RefreshArticlesEvent event,
    Emitter<ArticleState> emit,
  ) async {
    final result = await getArticlesUseCase(page: 1);

    result.fold(
      (failure) => emit(ArticleError(failure)),
      (response) => emit(
        ArticleLoaded(
          banner: response.banner,
          articles: response.articles,
          currentPage: response.pageSelected,
          totalPages: response.pages,
        ),
      ),
    );
  }

  Future<void> _onLoadPage(
    LoadPageEvent event,
    Emitter<ArticleState> emit,
  ) async {
    final currentState = state;

    // Si ya estamos en esa página, no hacer nada
    if (currentState is ArticleLoaded &&
        currentState.currentPage == event.page) {
      return;
    }

    // NO emitir ningún estado intermedio, solo el resultado final
    final result = await getArticlesUseCase(page: event.page);

    result.fold(
      (failure) => emit(ArticleError(failure)),
      (response) => emit(
        ArticleLoaded(
          banner: currentState is ArticleLoaded
              ? currentState.banner
              : response.banner,
          articles: response.articles,
          currentPage: response.pageSelected,
          totalPages: response.pages,
        ),
      ),
    );
  }
}