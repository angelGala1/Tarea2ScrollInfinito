import 'package:flutter/material.dart';

import 'app_dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    if (AppDimensions.isDesktop(context)) {
      return desktop ?? tablet ?? mobile;
    }

    if (AppDimensions.isTablet(context)) {
      return tablet ?? mobile;
    }

    return mobile;
  }
}

// Container con padding responsive automático
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final bool centerContent;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.centerContent = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.screenPadding(context),
        vertical: AppDimensions.verticalPadding(context),
      ),
      child: centerContent
          ? Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppDimensions.maxContentWidth(context),
          ),
          child: child,
        ),
      )
          : child,
    );
  }
}