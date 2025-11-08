import 'package:flutter/material.dart';

class AppDimensions {
  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;
  static const double desktopBreakpoint = 1440;

  // Detectar tipo de dispositivo
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileBreakpoint &&
          MediaQuery.of(context).size.width < tabletBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletBreakpoint;

  // ============== PADDING & MARGIN ==============

  // Padding horizontal de pantalla
  static double screenPadding(BuildContext context) {
    if (isMobile(context)) return 16;
    if (isTablet(context)) return 32;
    return 48; // Desktop
  }

  // Padding vertical
  static double verticalPadding(BuildContext context) {
    if (isMobile(context)) return 16;
    if (isTablet(context)) return 24;
    return 32; // Desktop
  }

  // Espaciado entre elementos
  static double spacing(BuildContext context) {
    if (isMobile(context)) return 12;
    if (isTablet(context)) return 16;
    return 20; // Desktop
  }

  // Espaciado pequeño
  static double spacingSmall(BuildContext context) {
    if (isMobile(context)) return 8;
    if (isTablet(context)) return 10;
    return 12; // Desktop
  }

  // Espaciado grande
  static double spacingLarge(BuildContext context) {
    if (isMobile(context)) return 24;
    if (isTablet(context)) return 32;
    return 40; // Desktop
  }

  // ============== TAMAÑOS DE COMPONENTES ==============

  // Altura de botones
  static double buttonHeight(BuildContext context) {
    if (isMobile(context)) return 48;
    if (isTablet(context)) return 52;
    return 56; // Desktop
  }

  // Ancho máximo de contenido (para centrar en desktop)
  static double maxContentWidth(BuildContext context) {
    if (isMobile(context)) return double.infinity;
    if (isTablet(context)) return 700;
    return 1200; // Desktop
  }

  // Border radius
  static double borderRadius(BuildContext context) {
    if (isMobile(context)) return 12;
    if (isTablet(context)) return 14;
    return 16; // Desktop
  }

  // Border radius pequeño
  static double borderRadiusSmall(BuildContext context) {
    if (isMobile(context)) return 8;
    if (isTablet(context)) return 10;
    return 12; // Desktop
  }

  // Tamaño de iconos
  static double iconSize(BuildContext context) {
    if (isMobile(context)) return 24;
    if (isTablet(context)) return 28;
    return 32; // Desktop
  }

  // ============== HELPER METHODS ==============

  // Obtener medida responsive personalizada
  static double responsive(
      BuildContext context, {
        required double mobile,
        double? tablet,
        double? desktop,
      }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet ?? mobile * 1.2;
    return desktop ?? mobile * 1.5;
  }
}