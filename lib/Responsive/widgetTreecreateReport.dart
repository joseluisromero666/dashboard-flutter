import 'package:argon_flutter/screens/createReports.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'responsiveController.dart';

class WidgetTreeCreateReport extends StatefulWidget {
  final index;
  WidgetTreeCreateReport({this.index});
  @override
  _WidgetTreeCreateReport createState() => _WidgetTreeCreateReport();
}

class _WidgetTreeCreateReport extends State<WidgetTreeCreateReport> {
  _WidgetTreeCreateReport();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: ResponsiveLayout(
        phone: CreateReports(),
        tablet: Row(
          children: [
            Expanded(
              flex: 9,
              child: CreateReports(),
            )
          ],
        ),
        desktop: Row(
          children: [
            Expanded(
              flex: _size.width > 1340 ? 1 : 3,
              child: ArgonDrawer(),
            ),
            Expanded(
              flex: _size.width > 1340 ? 10 : 14,
              child: CreateReports(),
            )
          ],
        ),
      ),
    );
  }
}
