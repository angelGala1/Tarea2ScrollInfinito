import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../core/utils/response_container.dart';
import '../../../core/utils/response_layout.dart' hide ResponsiveContainer;
import '../../domain/entitie/article_entity.dart';
import '../blocs/article/get_article_bloc.dart';
import '../blocs/article/get_article_event.dart';
import '../blocs/article/get_article_state.dart';
import '../widgets/component_article_card.dart';
import '../widgets/component_banner.dart';
import '../widgets/component_drawer.dart';
import '../widgets/component_pagination.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.read<ArticleBloc>().add(const LoadArticlesEvent());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ArticleBloc>().add(const LoadMoreArticlesEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 200);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF4A2FCF), // color morado similar
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white), // 👈 fuerza los íconos blancos

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/img/logito2.png', // 👈 tu logo
                  height: 62,
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),

      endDrawer: const CustomDrawer(), // 👈 Drawer a la derecha
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          if (state is ArticleLoading) {
            return _buildInitialLoading(context);
          }

          if (state is ArticleError) {
            return _buildErrorState(context, state.errorMessage);
          }

          if (state is ArticleLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ArticleBloc>().add(const RefreshArticlesEvent());
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: ResponsiveContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FeaturedBanner(),

                      SizedBox(
                        height: AppDimensions.spacingLarge(context) * 1.5,
                      ),
                      PaginationWidget(
                        currentPage: state.currentPage,
                        totalPages: state.totalPages,
                        onPageChanged: (page) {
                          print("hola");
                          context.read<ArticleBloc>().add(LoadPageEvent(page));
                          if (_scrollController.hasClients) {
                            _scrollController.jumpTo(0); // jumpTo es instantáneo
                          }
                          print("hola2");
                        },
                      ),


                      // Título de sección
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.screenPadding(context),
                        ),
                        child: const Text(
                          'Últimos artículos',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1D3D),
                          ),
                        ),
                      ),
                      SizedBox(height: AppDimensions.spacing(context)),

                      // Lista de artículos
                      ResponsiveLayout(
                        mobile: _buildMobileLayout(context, state.articles),
                       tablet: _buildTabletLayout(context, state.articles),
                         desktop: _buildDesktopLayout(context, state.articles),
                       ),

                      // Indicador de carga al final
                      if (state.isLoadingMore)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: Column(
                              children: [
                                const CircularProgressIndicator(),
                                const SizedBox(height: 12),
                                Text(
                                  'Cargando más artículos...',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Mensaje cuando no hay más páginas
                      if (!state.hasMorePages && !state.isLoadingMore)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: Text(
                              'No hay más artículos',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),

                      SizedBox(height: AppDimensions.spacingLarge(context)),
                    ],
                  ),
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  // MOBILE LAYOUT
  Widget _buildMobileLayout(
      BuildContext context,
      List<ArticleEntity> articles,
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.screenPadding(context),
      ),
      child: ListView.builder(  // ← Usar ListView.builder en vez de Column
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ArticleCard(
              article: articles[index],
              onTap: () {
                // Navegar al detalle
              },
            ),
          );
        },
      ),
    );
  }
  // TABLET LAYOUT
  Widget _buildTabletLayout(
    BuildContext context,
    List<ArticleEntity> articles,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.screenPadding(context),
      ),
      child: ListView.builder(  // ← Usar ListView.builder en vez de Column
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ArticleCard(
              article: articles[index],
              onTap: () {
                // Navegar al detalle
              },
            ),
          );
        },

      ),
    );
  }

  // DESKTOP LAYOUT
  Widget _buildDesktopLayout(
    BuildContext context,
    List<ArticleEntity> articles,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.screenPadding(context),
      ),
      child: ListView.builder(  // ← Usar ListView.builder en vez de Column
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ArticleCard(
              article: articles[index],
              onTap: () {
                // Navegar al detalle
              },
            ),
          );
        },
      ),
    );
  }

  // LOADING INICIAL
  Widget _buildInitialLoading(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveContainer(
        child: Column(
          children: [
            // Banner skeleton
            Container(
              height: AppDimensions.isMobile(context) ? 450 : 400,
              margin: EdgeInsets.all(AppDimensions.screenPadding(context)),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(
                  AppDimensions.borderRadius(context),
                ),
              ),
              child: const Center(child: CircularProgressIndicator()),
            ),

            SizedBox(height: AppDimensions.spacingLarge(context)),

            // Artículos skeleton
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.screenPadding(context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título skeleton
                  Container(
                    height: 30,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Cards skeleton
                  ...List.generate(3, (index) {
                    return Container(
                      height: AppDimensions.isMobile(context) ? 350 : 240,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadius(context),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ERROR STATE
  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.read<ArticleBloc>().add(const LoadArticlesEvent());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A2FCF),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Reintentar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
