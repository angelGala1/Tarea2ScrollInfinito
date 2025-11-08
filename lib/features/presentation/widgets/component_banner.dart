import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrolinfinitos/core/theme/app_colors.dart';

import '../../../core/utils/app_dimensions.dart';
import '../../domain/entitie/banner_entity.dart';
import '../blocs/article/get_article_bloc.dart';
import '../blocs/article/get_article_state.dart';
class FeaturedBanner extends StatelessWidget {
  const FeaturedBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        if (state is ArticleLoading) {
          return _buildLoadingSkeleton(context);
        }

        if (state is ArticleError) {
          return _buildErrorBanner(context, state.errorMessage);
        }

        if (state is ArticleLoaded) {
          final banner = state.banner;

          // Desktop y Tablet: Banner horizontal
          if (AppDimensions.isDesktop(context) || AppDimensions.isTablet(context)) {
            return _buildHorizontalBanner(context, banner);
          }
          // Mobile: Banner vertical
          return _buildVerticalBanner(context, banner);
        }

        return const SizedBox();
      },
    );
  }

  // Banner MOBILE (vertical)
  Widget _buildVerticalBanner(BuildContext context, BannerEntity banner) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(AppDimensions.screenPadding(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¡Nuevo artículo!',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: AppDimensions.spacing(context)),
                Text(
                  banner.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1D3D),
                    height: 1.3,
                  ),
                ),
                SizedBox(height: AppDimensions.spacingSmall(context)),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(AppDimensions.borderRadius(context)),
              ),
              child: Image.network(
                banner.urlImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 270,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 270,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image, size: 50),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 270,
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.backgroundCardButton,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                // Navegar al artículo
              },
              child: Text(
                'Leer más',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.textoBlanco,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Banner TABLET y DESKTOP (horizontal)
  Widget _buildHorizontalBanner(BuildContext context, BannerEntity banner) {
    final isDesktop = AppDimensions.isDesktop(context);
    final titleSize = isDesktop ? 32.0 : 26.0;
    final descriptionSize = isDesktop ? 16.0 : 15.0;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.screenPadding(context) * 1.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¡Nuevo artículo!',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: isDesktop ? 13 : 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: AppDimensions.spacing(context)),
                  Text(
                    banner.title,
                    style: GoogleFonts.poppins(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1D3D),
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: AppDimensions.spacing(context)),
                  Text(
                    banner.shortDescription,
                    style: TextStyle(
                      fontSize: descriptionSize,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (isDesktop) ...[
                    SizedBox(height: AppDimensions.spacingLarge(context)),
                    SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.backgroundCardButton,
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Leer más',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              margin: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimensions.borderRadius(context)),
                ),
                child: Image.network(
                  banner.urlImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 470,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 470,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, size: 80),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 470,
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSkeleton(BuildContext context) {
    if (AppDimensions.isDesktop(context) || AppDimensions.isTablet(context)) {
      return Container(
        height: 400,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius(context)),
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    return Container(
      height: 450,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius(context)),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorBanner(BuildContext context, String message) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius(context)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const SizedBox(width: 12),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}
