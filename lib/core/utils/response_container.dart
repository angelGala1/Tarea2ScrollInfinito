import 'package:flutter/cupertino.dart';

import 'app_dimensions.dart';

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