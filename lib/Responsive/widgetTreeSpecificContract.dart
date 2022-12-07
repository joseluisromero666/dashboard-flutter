import 'package:argon_flutter/screens/specificContract.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'responsiveController.dart';

class WidgetTreeSpecificContract extends StatefulWidget {
  final index;
  WidgetTreeSpecificContract({this.index});
  @override
  _WidgetTreeSpecificContract createState() => _WidgetTreeSpecificContract();
}

class _WidgetTreeSpecificContract extends State<WidgetTreeSpecificContract> {
  _WidgetTreeSpecificContract();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: ResponsiveLayout(
        phone: SpecificContract(),
        tablet: Row(
          children: [
            Expanded(
              flex: 9,
              child: SpecificContract(),
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
              child: SpecificContract(),
            )
          ],
        ),
      ),
    );
  }
}
