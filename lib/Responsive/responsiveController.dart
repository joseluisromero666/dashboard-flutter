import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget phone;
  final Widget tablet;
  final Widget desktop;
  const ResponsiveLayout({Key key, this.phone, this.tablet, this.desktop}) : super(key: key);

  static int phoneLimit = 600;
  static int tabletLimit = 1000;

  static bool isPhone(BuildContext context) => MediaQuery.of(context).size.width < phoneLimit;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletLimit && MediaQuery.of(context).size.width >= phoneLimit;

  static bool isRotated(BuildContext context) => MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= tabletLimit;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < phoneLimit) {
        return phone;
      }
      if (constraints.maxWidth < tabletLimit) {
        return tablet;
      }
      return desktop;
    });
  }
}
